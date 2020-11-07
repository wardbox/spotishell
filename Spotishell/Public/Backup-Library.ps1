<#
    .SYNOPSIS
        Backup Library items to json file (FollowedArtists, SavedAlbums, SavedShows, SavedTracks)
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

        [ValidateSet('All', 'FollowedArtists', 'SavedAlbums', 'SavedShows', 'SavedTracks')]
        [array]
        $Type = 'All',

        [string]
        $ApplicationName
    )
    
#TODO autogenerate path if not provided then inform

    $Backup = @{}

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
        $Backup.saved_trackss = ((Get-CurrentUserSavedTracks -ApplicationName $ApplicationName).track | Select-Object name, id)
    }

    Set-Content -Path $Path -Value (ConvertTo-Json -InputObject $Backup) -Encoding Unicode
}