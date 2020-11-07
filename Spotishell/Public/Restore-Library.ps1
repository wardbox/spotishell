<#
    .SYNOPSIS
        Restore Libraries items from json file (FollowedArtists, SavedAlbums, SavedShows, SavedTracks)
    .EXAMPLE
        PS C:\> Restore-Library -Path $FilePath
        Restore all Library items from '.\mySpotifyBackup.json'
    .EXAMPLE
        PS C:\> Restore-Library -Type FollowedArtists,SavedAlbums -Path $FilePath
        Restore Followed Artists and Saved Albums items from '.\mySpotifyBackup.json'
    .PARAMETER Path
        Path of the backup file you want to restore
    .PARAMETER Type
        One or more items type to restore (All, FollowedArtists, SavedAlbums, SavedShows, SavedTracks)
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Restore-Library {
    param (
        [Parameter(Mandatory)]
        [string]
        $Path,

        [ValidateSet('All', 'FollowedArtists', 'SavedAlbums', 'SavedShows', 'SavedTracks')]
        [array]
        $Type = 'All',

        [string]
        $ApplicationName
    )

    $Backup = Get-Content -Path $Path -Raw | ConvertFrom-Json

    if ($Type -contains 'FollowedArtists' -or $Type -contains 'All') {
        if ($Backup.followed_artists.id.Count -gt 0) {
            Add-FollowedArtist -Ids $Backup.followed_artists.id -ApplicationName $ApplicationName
        }
    }

    if ($Type -contains 'SavedAlbums' -or $Type -contains 'All') {
        if ($Backup.saved_albums.id.Count -gt 0) {
            Add-CurrentUserSavedAlbum -Ids $Backup.saved_albums.id -ApplicationName $ApplicationName
        }
    }

    if ($Type -contains 'SavedShows' -or $Type -contains 'All') {
        if ($Backup.saved_shows.id.Count -gt 0) {
            Add-CurrentUserSavedShow -Ids $Backup.saved_shows.id -ApplicationName $ApplicationName
        }
    }

    if ($Type -contains 'SavedTracks' -or $Type -contains 'All') {
        if ($Backup.saved_trackss.id.Count -gt 0) {
            Add-CurrentUserSavedTrack -Ids $Backup.saved_trackss.id -ApplicationName $ApplicationName
        }
    }

    Write-Host -BackgroundColor Magenta -ForegroundColor White 'It may take few minutes before library items appears. Please be patient.'
}