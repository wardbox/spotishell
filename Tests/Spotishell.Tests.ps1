BeforeAll {
    $ModulePath = Join-Path $PSScriptRoot '..' 'Spotishell' 'Spotishell.psd1'
    $PrivatePath = Join-Path $PSScriptRoot '..' 'Spotishell' 'Private'
    Import-Module $ModulePath -Force
}

Describe 'Spotishell Module' {
    Context 'Module Loading' {
        It 'Should import without errors' {
            { Import-Module $ModulePath -Force } | Should -Not -Throw
        }

        It 'Should export commands' {
            $commands = Get-Command -Module Spotishell
            $commands.Count | Should -BeGreaterThan 0
        }

        It 'Should export expected command categories' {
            $commands = Get-Command -Module Spotishell
            $commandNames = $commands.Name

            # Core application management
            $commandNames | Should -Contain 'New-SpotifyApplication'
            $commandNames | Should -Contain 'Get-SpotifyApplication'
            $commandNames | Should -Contain 'Remove-SpotifyApplication'

            # User profile
            $commandNames | Should -Contain 'Get-CurrentUserProfile'

            # Playback
            $commandNames | Should -Contain 'Get-CurrentTrack'
            $commandNames | Should -Contain 'Get-AvailableDevices'
        }
    }

    Context 'Module Manifest' {
        BeforeAll {
            $manifest = Test-ModuleManifest -Path $ModulePath
        }

        It 'Should have a valid manifest' {
            $manifest | Should -Not -BeNullOrEmpty
        }

        It 'Should have a version number' {
            $manifest.Version | Should -Not -BeNullOrEmpty
        }

        It 'Should have a description' {
            $manifest.Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have an author' {
            $manifest.Author | Should -Not -BeNullOrEmpty
        }

        It 'Should require PowerShell 5.0 or higher' {
            $manifest.PowerShellVersion | Should -BeGreaterOrEqual '5.0'
        }
    }
}

Describe 'Private Functions' {
    BeforeAll {
        # Dot-source private functions for testing
        . (Join-Path $PrivatePath 'Get-SpotifyAccessToken.ps1')
        . (Join-Path $PrivatePath 'Get-StorePath.ps1')
        . (Join-Path $PrivatePath 'Get-NonAsciiCharEscaped.ps1')
    }

    Context 'New-PkceChallenge' {
        It 'Should generate a code verifier' {
            $pkce = New-PkceChallenge
            $pkce.Verifier | Should -Not -BeNullOrEmpty
        }

        It 'Should generate a code challenge' {
            $pkce = New-PkceChallenge
            $pkce.Challenge | Should -Not -BeNullOrEmpty
        }

        It 'Should generate verifier within valid length (43-128 chars)' {
            $pkce = New-PkceChallenge
            $pkce.Verifier.Length | Should -BeGreaterOrEqual 43
            $pkce.Verifier.Length | Should -BeLessOrEqual 128
        }

        It 'Should generate challenge of correct length (43 chars for SHA256 base64url)' {
            $pkce = New-PkceChallenge
            $pkce.Challenge.Length | Should -Be 43
        }

        It 'Should generate unique values each time' {
            $pkce1 = New-PkceChallenge
            $pkce2 = New-PkceChallenge
            $pkce1.Verifier | Should -Not -Be $pkce2.Verifier
            $pkce1.Challenge | Should -Not -Be $pkce2.Challenge
        }

        It 'Should use base64url encoding (no +, /, or = chars)' {
            $pkce = New-PkceChallenge
            $pkce.Verifier | Should -Not -Match '[+/=]'
            $pkce.Challenge | Should -Not -Match '[+/=]'
        }

        It 'Should only contain valid base64url characters' {
            $pkce = New-PkceChallenge
            $pkce.Verifier | Should -Match '^[A-Za-z0-9_-]+$'
            $pkce.Challenge | Should -Match '^[A-Za-z0-9_-]+$'
        }
    }

    Context 'Get-StorePath' {
        It 'Should return a non-empty path' {
            $path = Get-StorePath
            $path | Should -Not -BeNullOrEmpty
        }

        It 'Should return path ending with spotishell folder' {
            $path = Get-StorePath
            $path | Should -Match 'spotishell[/\\]$'
        }

        It 'Should respect SPOTISHELL_STORE_PATH environment variable' {
            $originalValue = $env:SPOTISHELL_STORE_PATH
            try {
                $env:SPOTISHELL_STORE_PATH = '/custom/path'
                $path = Get-StorePath
                $path | Should -BeLike '/custom/path*'
            }
            finally {
                $env:SPOTISHELL_STORE_PATH = $originalValue
            }
        }
    }

    Context 'Get-NonAsciiCharEscaped' {
        It 'Should return ASCII strings unchanged' {
            $result = Get-NonAsciiCharEscaped 'Hello World'
            $result | Should -Be 'Hello World'
        }

        It 'Should escape non-ASCII characters' {
            $result = Get-NonAsciiCharEscaped 'Héllo'
            $result | Should -Be 'H\u00e9llo'
        }

        It 'Should escape multiple non-ASCII characters' {
            $result = Get-NonAsciiCharEscaped 'Héllö'
            $result | Should -Match '\\u00e9'
            $result | Should -Match '\\u00f6'
        }

        It 'Should reject empty strings (mandatory parameter)' {
            { Get-NonAsciiCharEscaped '' } | Should -Throw
        }

        It 'Should accept pipeline input' {
            $result = 'Tëst' | Get-NonAsciiCharEscaped
            $result | Should -Match '\\u00eb'
        }
    }
}

Describe 'Application Management' {
    BeforeAll {
        # Dot-source private function needed for path resolution
        . (Join-Path $PrivatePath 'Get-StorePath.ps1')

        # Use a temporary store path for testing
        $testStorePath = Join-Path $TestDrive 'spotishell-test'
        New-Item -Path $testStorePath -ItemType Directory -Force | Out-Null
        $env:SPOTISHELL_STORE_PATH = $testStorePath
    }

    AfterAll {
        $env:SPOTISHELL_STORE_PATH = $null
    }

    Context 'New-SpotifyApplication' {
        It 'Should create a new application' {
            $app = New-SpotifyApplication -Name 'test-app' -ClientId 'test-id' -ClientSecret 'test-secret'
            $app | Should -Not -BeNullOrEmpty
            $app.Name | Should -Be 'test-app'
            $app.ClientId | Should -Be 'test-id'
        }

        It 'Should use default redirect URI' {
            $app = New-SpotifyApplication -Name 'test-app2' -ClientId 'test-id2' -ClientSecret 'test-secret2'
            $app.RedirectUri | Should -Be 'http://127.0.0.1:8080/spotishell'
        }

        It 'Should allow custom redirect URI' {
            $app = New-SpotifyApplication -Name 'test-app3' -ClientId 'test-id3' -ClientSecret 'test-secret3' -RedirectUri 'http://localhost:9000/callback'
            $app.RedirectUri | Should -Be 'http://localhost:9000/callback'
        }

        It 'Should create application file in store' {
            New-SpotifyApplication -Name 'test-file-app' -ClientId 'file-id' -ClientSecret 'file-secret'
            $storePath = Get-StorePath
            $filePath = Join-Path $storePath 'test-file-app.json'
            Test-Path $filePath | Should -Be $true
        }
    }

    Context 'Get-SpotifyApplication' {
        BeforeAll {
            New-SpotifyApplication -Name 'get-test-app' -ClientId 'get-test-id' -ClientSecret 'get-test-secret'
        }

        It 'Should retrieve an existing application' {
            $app = Get-SpotifyApplication -Name 'get-test-app'
            $app | Should -Not -BeNullOrEmpty
            $app.ClientId | Should -Be 'get-test-id'
        }

        It 'Should throw for non-existent application' {
            { Get-SpotifyApplication -Name 'non-existent-app' } | Should -Throw
        }
    }

    Context 'Remove-SpotifyApplication' {
        BeforeEach {
            New-SpotifyApplication -Name 'remove-test-app' -ClientId 'remove-id' -ClientSecret 'remove-secret'
        }

        It 'Should remove an existing application' {
            Remove-SpotifyApplication -Name 'remove-test-app'
            $filePath = Join-Path $env:SPOTISHELL_STORE_PATH 'remove-test-app.json'
            Test-Path $filePath | Should -Be $false
        }
    }
}

Describe 'Parameter Validation' {
    Context 'Search-Item' {
        It 'Should require Query parameter' {
            { Search-Item -Type Artist } | Should -Throw
        }

        It 'Should require Type parameter' {
            { Search-Item -Query 'test' } | Should -Throw
        }

        It 'Should accept valid Type values' {
            $cmd = Get-Command Search-Item
            $validateSet = $cmd.Parameters['Type'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $validateSet | Should -Not -BeNullOrEmpty
            $validateSet.ValidValues | Should -Contain 'Album'
            $validateSet.ValidValues | Should -Contain 'Artist'
            $validateSet.ValidValues | Should -Contain 'Playlist'
        }
    }

    Context 'Get-Track' {
        It 'Should require Id parameter' {
            { Get-Track } | Should -Throw
        }
    }

    Context 'Get-Artist' {
        It 'Should require Id parameter' {
            { Get-Artist } | Should -Throw
        }
    }

    Context 'Get-Album' {
        It 'Should require Id parameter' {
            { Get-Album } | Should -Throw
        }
    }

    Context 'Add-PlaylistItem' {
        It 'Should have ItemType parameter with valid values' {
            $cmd = Get-Command Add-PlaylistItem
            $validateSet = $cmd.Parameters['ItemType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $validateSet | Should -Not -BeNullOrEmpty
            $validateSet.ValidValues | Should -Contain 'track'
            $validateSet.ValidValues | Should -Contain 'episode'
        }

        It 'Should have ItemType default to track' {
            $cmd = Get-Command Add-PlaylistItem
            $cmd.Parameters['ItemType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }
            # Check that the default value is 'track' by examining the function definition
            $functionDef = (Get-Command Add-PlaylistItem).ScriptBlock.ToString()
            $functionDef | Should -Match '\$ItemType\s*=\s*[''"]track[''"]'
        }

        It 'Should require Id parameter' {
            { Add-PlaylistItem -ItemId 'test-id' } | Should -Throw
        }

        It 'Should require ItemId parameter' {
            { Add-PlaylistItem -Id 'test-playlist' } | Should -Throw
        }
    }

    Context 'Get-RecentlyPlayedTracks' {
        It 'Should have IncludePlayContext switch parameter' {
            $cmd = Get-Command Get-RecentlyPlayedTracks
            $cmd.Parameters['IncludePlayContext'] | Should -Not -BeNullOrEmpty
            $cmd.Parameters['IncludePlayContext'].SwitchParameter | Should -Be $true
        }

        It 'Should have Limit parameter with range validation' {
            $cmd = Get-Command Get-RecentlyPlayedTracks
            $validateRange = $cmd.Parameters['Limit'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateRangeAttribute] }
            $validateRange | Should -Not -BeNullOrEmpty
            $validateRange.MinRange | Should -Be 1
            $validateRange.MaxRange | Should -Be 50
        }
    }
}

Describe 'Add-PlaylistItem Behavior' {
    BeforeAll {
        Mock Send-SpotifyCall { return @{ snapshot_id = 'mock-snapshot' } } -ModuleName Spotishell
    }

    Context 'URI Conversion' {
        It 'Should convert a single plain ID to spotify:track URI' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'track456'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match '"uris":\["spotify:track:track456"\]'
            }
        }

        It 'Should convert multiple plain IDs to spotify:track URIs' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'track1', 'track2', 'track3'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match 'spotify:track:track1' -and
                $Body -match 'spotify:track:track2' -and
                $Body -match 'spotify:track:track3'
            }
        }

        It 'Should pass through existing spotify:track URIs unchanged' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'spotify:track:existing123'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match '"uris":\["spotify:track:existing123"\]'
            }
        }

        It 'Should pass through existing spotify:episode URIs unchanged' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'spotify:episode:episode123'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match '"uris":\["spotify:episode:episode123"\]'
            }
        }

        It 'Should use episode prefix when ItemType is episode' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'episode456' -ItemType 'episode'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match '"uris":\["spotify:episode:episode456"\]'
            }
        }

        It 'Should handle mixed URIs and plain IDs' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'plain123', 'spotify:track:existing456'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match 'spotify:track:plain123' -and
                $Body -match 'spotify:track:existing456'
            }
        }

        It 'Should not split single item into characters (array handling)' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'singletrack'

            # This would fail if the bug existed - body would contain individual characters
            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -notmatch '"s","i","n","g","l","e"' -and
                $Body -match 'spotify:track:singletrack'
            }
        }
    }

    Context 'API Call' {
        It 'Should call correct playlist endpoint' {
            Add-PlaylistItem -Id 'myplaylist789' -ItemId 'track123'

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Uri -eq 'https://api.spotify.com/v1/playlists/myplaylist789/tracks' -and
                $Method -eq 'Post'
            }
        }

        It 'Should include position in API call when specified' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'track456' -Position 5

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match '"position":5'
            }
        }

        It 'Should include position 0 in API call' {
            Add-PlaylistItem -Id 'playlist123' -ItemId 'track456' -Position 0

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Body -match '"position":0'
            }
        }
    }
}

Describe 'Get-RecentlyPlayedTracks Behavior' {
    Context 'Response Handling' {
        BeforeAll {
            # Mock response matching Spotify API structure
            $mockResponse = @{
                items = @(
                    @{
                        played_at = '2025-12-01T17:21:53.000Z'
                        context   = @{ type = 'playlist'; uri = 'spotify:playlist:abc' }
                        track     = @{ id = 'track1'; name = 'Song 1'; artists = @(@{ name = 'Artist 1' }) }
                    },
                    @{
                        played_at = '2025-12-01T16:00:00.000Z'
                        context   = @{ type = 'album'; uri = 'spotify:album:xyz' }
                        track     = @{ id = 'track2'; name = 'Song 2'; artists = @(@{ name = 'Artist 2' }) }
                    }
                )
            }
            Mock Send-SpotifyCall { return $mockResponse } -ModuleName Spotishell
        }

        It 'Should return only track objects by default' {
            $result = Get-RecentlyPlayedTracks

            $result.Count | Should -Be 2
            $result[0].name | Should -Be 'Song 1'
            $result[0].PSObject.Properties.Name | Should -Not -Contain 'played_at'
        }

        It 'Should return full items with played_at when IncludePlayContext is set' {
            $result = Get-RecentlyPlayedTracks -IncludePlayContext

            $result.Count | Should -Be 2
            $result[0].played_at | Should -Be '2025-12-01T17:21:53.000Z'
            $result[0].track.name | Should -Be 'Song 1'
            $result[0].context.type | Should -Be 'playlist'
        }

        It 'Should call API with correct limit parameter' {
            Get-RecentlyPlayedTracks -Limit 10

            Should -Invoke Send-SpotifyCall -ModuleName Spotishell -ParameterFilter {
                $Uri -match 'limit=10'
            }
        }
    }
}
