<#
    .SYNOPSIS
        Backup Library items to json file (FollowedArtists, Playlists, SavedAlbums, SavedShows, SavedTracks)
    .EXAMPLE
        PS C:\> Backup-Library -Path '.\mySpotifyBackup.json'
        Backup all Library items into '.\mySpotifyBackup.json'
    .EXAMPLE
        PS C:\> Backup-Library -Type FollowedArtists,SavedAlbums -Path '.\mySpotifyBackup.json'
        Backup Followed Artists and Saved Albums items into '.\mySpotifyBackup.json'
    .PARAMETER Path
        Path of the backup file you want to create
    .PARAMETER Type
        One or more items type to backup (All, FollowedArtists, SavedAlbums, SavedShows, SavedTracks)
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Backup-Library {
    param (
        [Parameter(Mandatory)]
        [string]
        $Path,

        [ValidateSet('All', 'Playlists', 'FollowedArtists', 'SavedAlbums', 'SavedShows', 'SavedTracks')]
        [array]
        $Type = 'All',

        [string]
        $ApplicationName
    )
    
    #TODO autogenerate path if not provided then inform

    $Backup = @{}

    if ($Type -contains 'Playlists' -or $Type -contains 'All') {
        $Playlists = [array](Get-CurrentUserPlaylists -ApplicationName $ApplicationName)
        $MyId = (Get-CurrentUserProfile -ApplicationName $ApplicationName).id

        # process followed playlists (owner is not me)
        $Backup.followed_playlists = foreach ($playlist in $Playlists.Where( { $_.owner.id -ne $MyId })) {
            $playlist | Select-Object id, public
        }
        
        # process my playlists (owner is me)
        $Backup.my_playlists = foreach ($playlist in $Playlists.Where( { $_.owner.id -eq $MyId })) {
            [PSCustomObject]@{
                id            = $playlist.id
                name          = $playlist.name
                public        = $playlist.public
                collaborative = $playlist.collaborative
                description   = $playlist.description
                tracks        = (Get-PlaylistItems -Id $playlist.id -ApplicationName $ApplicationName).track.uri
                image         = & {
                    if ($null -ne $playlist.images) {
                        $image = ($playlist.images | Sort-Object -Property height -Descending)[0]
                        $ProgressPreference = 'SilentlyContinue'
                        $imgBytes = (Invoke-WebRequest $image.url).Content
                        $ProgressPreference = 'Continue'
                        [Convert]::ToBase64String($imgBytes)
                    }
                }
            }
        }
    }

    if ($Type -contains 'FollowedArtists' -or $Type -contains 'All') {
        $Backup.followed_artists = (Get-FollowedArtists -ApplicationName $ApplicationName | Select-Object name, id)
    }

    if ($Type -contains 'SavedAlbums' -or $Type -contains 'All') {
        $Backup.saved_albums = ((Get-CurrentUserSavedAlbums -ApplicationName $ApplicationName).album | Select-Object name, id)
    }

    if ($Type -contains 'SavedShows' -or $Type -contains 'All') {
        $Backup.saved_shows = ((Get-CurrentUserSavedShows -ApplicationName $ApplicationName).show | Select-Object name, id)
    }

    if ($Type -contains 'SavedTracks' -or $Type -contains 'All') {
        $Backup.saved_tracks = ((Get-CurrentUserSavedTracks -ApplicationName $ApplicationName).track | Select-Object name, id)
    }

    Set-Content -Path $Path -Value (ConvertTo-Json -Depth 10 -InputObject $Backup) -Encoding UTF8
}