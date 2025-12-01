<#
.SYNOPSIS
    Integration tests for Spotishell module.
    These tests require valid Spotify API credentials and make real API calls.

.DESCRIPTION
    Run these tests manually when you want to verify the module works with the real Spotify API.

    Prerequisites:
    1. Copy .env.example to .env and fill in your credentials
    2. Run: Invoke-Pester -Path ./Tests/Spotishell.Integration.Tests.ps1 -Output Detailed

.NOTES
    These tests run in CI on main branch only (after PR merge).
    They require GitHub Secrets:
    - SPOTIFY_CLIENT_ID
    - SPOTIFY_CLIENT_SECRET
#>

BeforeAll {
    $ModulePath = Join-Path $PSScriptRoot '..' 'Spotishell' 'Spotishell.psd1'
    Import-Module $ModulePath -Force

    # Load .env file if it exists (for local development)
    $EnvFile = Join-Path $PSScriptRoot '..' '.env'
    if (Test-Path $EnvFile) {
        Get-Content $EnvFile | ForEach-Object {
            if ($_ -match '^\s*([^#][^=]+)=(.*)$') {
                $name = $matches[1].Trim()
                $value = $matches[2].Trim()
                Set-Item -Path "env:$name" -Value $value
            }
        }
    }

    # Check for required credentials
    $script:SkipTests = $false
    if (-not $env:SPOTIFY_CLIENT_ID -or -not $env:SPOTIFY_CLIENT_SECRET) {
        Write-Warning "SPOTIFY_CLIENT_ID and SPOTIFY_CLIENT_SECRET environment variables are required for integration tests."
        Write-Warning "Copy .env.example to .env and fill in your credentials, or set environment variables."
        $script:SkipTests = $true
    }

    # Setup application and test playlist if credentials exist
    if (-not $script:SkipTests) {
        # For CI: if refresh token is provided, create the credential file directly
        # This allows non-interactive token refresh
        if ($env:SPOTIFY_REFRESH_TOKEN) {
            # Ensure store directory exists
            $StorePath = if ($env:SPOTISHELL_STORE_PATH) { $env:SPOTISHELL_STORE_PATH }
                         elseif ($IsWindows -or $PSVersionTable.PSVersion.Major -lt 6) { Join-Path $env:LOCALAPPDATA 'spotishell' }
                         else { Join-Path $HOME '.spotishell' }

            if (-not (Test-Path $StorePath)) {
                New-Item -Path $StorePath -ItemType Directory -Force | Out-Null
            }

            # Create application with pre-authorized refresh token
            $AppFile = Join-Path $StorePath 'integration-test.json'
            @{
                Name         = 'integration-test'
                ClientId     = $env:SPOTIFY_CLIENT_ID
                ClientSecret = $env:SPOTIFY_CLIENT_SECRET
                RedirectUri  = 'http://127.0.0.1:8080/spotishell'
                Token        = @{
                    refresh_token = $env:SPOTIFY_REFRESH_TOKEN
                    expires       = '1970-01-01 00:00:00Z'  # Force refresh on first use
                }
            } | ConvertTo-Json -Depth 10 | Set-Content -Path $AppFile -Encoding UTF8

            Write-Host "Created integration-test application with pre-authorized refresh token"
        }
        else {
            # Local development: check if application exists, create if not
            $app = $null
            try {
                $app = Get-SpotifyApplication -Name 'integration-test' -ErrorAction SilentlyContinue
            }
            catch {
                # Application doesn't exist, will create below
            }

            if (-not $app) {
                New-SpotifyApplication -Name 'integration-test' -ClientId $env:SPOTIFY_CLIENT_ID -ClientSecret $env:SPOTIFY_CLIENT_SECRET
            }
        }

        # Get current user for playlist creation
        $script:CurrentUser = Get-CurrentUserProfile -ApplicationName 'integration-test'

        # Create a temporary test playlist
        $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $script:TestPlaylist = New-Playlist -UserId $script:CurrentUser.id `
            -Name "Spotishell-Test-$timestamp" `
            -Description 'Temporary playlist for integration testing. Safe to delete.' `
            -Public $false `
            -ApplicationName 'integration-test'

        Write-Host "Created test playlist: $($script:TestPlaylist.name) ($($script:TestPlaylist.id))"
    }
}

Describe 'Integration: Authentication' -Skip:$script:SkipTests {
    It 'Should authenticate and get current user profile' {
        $profile = Get-CurrentUserProfile -ApplicationName 'integration-test'

        $profile | Should -Not -BeNullOrEmpty
        $profile.id | Should -Not -BeNullOrEmpty
        $profile.type | Should -Be 'user'
    }
}

Describe 'Integration: Get-RecentlyPlayedTracks' -Skip:$script:SkipTests {
    Context 'Basic Functionality' {
        It 'Should retrieve recently played tracks' {
            $tracks = Get-RecentlyPlayedTracks -Limit 5 -ApplicationName 'integration-test'

            # User might not have play history, so just check it doesn't error
            # If there are results, verify structure
            if ($tracks) {
                $tracks[0].name | Should -Not -BeNullOrEmpty
                $tracks[0].artists | Should -Not -BeNullOrEmpty
            }
        }

        It 'Should include played_at when IncludePlayContext is set' {
            $items = Get-RecentlyPlayedTracks -Limit 5 -IncludePlayContext -ApplicationName 'integration-test'

            if ($items) {
                $items[0].played_at | Should -Not -BeNullOrEmpty
                $items[0].track | Should -Not -BeNullOrEmpty
                $items[0].track.name | Should -Not -BeNullOrEmpty
            }
        }

        It 'Should respect Limit parameter' {
            $items = Get-RecentlyPlayedTracks -Limit 3 -ApplicationName 'integration-test'

            if ($items) {
                $items.Count | Should -BeLessOrEqual 3
            }
        }
    }
}

Describe 'Integration: Add-PlaylistItem' -Skip:$script:SkipTests {
    Context 'Adding tracks with plain IDs' {
        It 'Should add a track using plain ID (not full URI)' {
            # Use a well-known track ID (Rick Astley - Never Gonna Give You Up)
            $trackId = '4PTG3Z6ehGkBFwjybzWkR8'

            # This should not throw - the fix converts plain ID to URI
            { Add-PlaylistItem -Id $script:TestPlaylist.id -ItemId $trackId -ApplicationName 'integration-test' } | Should -Not -Throw
        }

        It 'Should add a track using full URI' {
            $trackUri = 'spotify:track:4PTG3Z6ehGkBFwjybzWkR8'

            { Add-PlaylistItem -Id $script:TestPlaylist.id -ItemId $trackUri -ApplicationName 'integration-test' } | Should -Not -Throw
        }

        It 'Should add multiple tracks at once' {
            $trackIds = @('4PTG3Z6ehGkBFwjybzWkR8', '7GhIk7Il098yCjg4BQjzvb')

            { Add-PlaylistItem -Id $script:TestPlaylist.id -ItemId $trackIds -ApplicationName 'integration-test' } | Should -Not -Throw
        }
    }
}

Describe 'Integration: Search' -Skip:$script:SkipTests {
    It 'Should search for tracks' {
        $results = Search-Item -Query 'Never Gonna Give You Up' -Type Track -ApplicationName 'integration-test'

        $results | Should -Not -BeNullOrEmpty
        $results.tracks.items | Should -Not -BeNullOrEmpty
        $results.tracks.items[0].name | Should -Not -BeNullOrEmpty
    }

    It 'Should search for artists' {
        $results = Search-Item -Query 'Rick Astley' -Type Artist -ApplicationName 'integration-test'

        $results | Should -Not -BeNullOrEmpty
        $results.artists.items | Should -Not -BeNullOrEmpty
    }
}

AfterAll {
    # Cleanup: Remove test playlist and application
    if ($script:TestPlaylist) {
        try {
            Write-Host "Cleaning up test playlist: $($script:TestPlaylist.id)"
            Remove-FollowedPlaylist -Id $script:TestPlaylist.id -ApplicationName 'integration-test' -ErrorAction SilentlyContinue
        }
        catch {
            Write-Warning "Could not remove test playlist: $_"
        }
    }

    try {
        Remove-SpotifyApplication -Name 'integration-test' -ErrorAction SilentlyContinue
    }
    catch {
        # Ignore cleanup errors
    }
}
