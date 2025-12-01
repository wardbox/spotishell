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
    These tests are NOT run as part of CI/CD pipelines.
    They require:
    - Valid Spotify API credentials (SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET)
    - A test playlist that can be modified
    - Active Spotify account with play history
#>

BeforeAll {
    $ModulePath = Join-Path $PSScriptRoot '..' 'Spotishell' 'Spotishell.psd1'
    Import-Module $ModulePath -Force

    # Load .env file if it exists
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

    # Setup application if credentials exist
    if (-not $script:SkipTests) {
        try {
            $app = Get-SpotifyApplication -Name 'integration-test' -ErrorAction SilentlyContinue
        }
        catch {
            New-SpotifyApplication -Name 'integration-test' -ClientId $env:SPOTIFY_CLIENT_ID -ClientSecret $env:SPOTIFY_CLIENT_SECRET
        }
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
    BeforeAll {
        # Get user's playlists to find a test playlist
        $script:TestPlaylistId = $env:SPOTIFY_TEST_PLAYLIST_ID

        if (-not $script:TestPlaylistId) {
            Write-Warning "Set SPOTIFY_TEST_PLAYLIST_ID environment variable to run Add-PlaylistItem tests"
            Write-Warning "Skipping Add-PlaylistItem integration tests"
        }
    }

    Context 'Adding tracks with plain IDs' -Skip:(-not $script:TestPlaylistId) {
        It 'Should add a track using plain ID (not full URI)' {
            # Use a well-known track ID (Rick Astley - Never Gonna Give You Up)
            $trackId = '4PTG3Z6ehGkBFwjybzWkR8'

            # This should not throw - the fix converts plain ID to URI
            { Add-PlaylistItem -Id $script:TestPlaylistId -ItemId $trackId -ApplicationName 'integration-test' } | Should -Not -Throw
        }

        It 'Should add a track using full URI' {
            $trackUri = 'spotify:track:4PTG3Z6ehGkBFwjybzWkR8'

            { Add-PlaylistItem -Id $script:TestPlaylistId -ItemId $trackUri -ApplicationName 'integration-test' } | Should -Not -Throw
        }

        It 'Should add multiple tracks at once' {
            $trackIds = @('4PTG3Z6ehGkBFwjybzWkR8', '7GhIk7Il098yCjg4BQjzvb')

            { Add-PlaylistItem -Id $script:TestPlaylistId -ItemId $trackIds -ApplicationName 'integration-test' } | Should -Not -Throw
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
    # Cleanup: Remove test application
    try {
        Remove-SpotifyApplication -Name 'integration-test' -ErrorAction SilentlyContinue
    }
    catch {
        # Ignore cleanup errors
    }
}
