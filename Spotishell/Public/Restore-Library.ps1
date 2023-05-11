<#
    .SYNOPSIS
        Restore Library items from json file (Playlists, FollowedArtists, SavedAlbums, SavedShows, SavedTracks)
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

        [ValidateSet('All', 'Playlists', 'FollowedArtists', 'SavedAlbums', 'SavedShows', 'SavedTracks')]
        [array]
        $Type = 'All',

        [string]
        $ApplicationName
    )

    $Backup = Get-Content -Path $Path -Encoding UTF8 -Raw | ConvertFrom-Json

    if ($Type -contains 'Playlists' -or $Type -contains 'All') {
        $MyId = (Get-CurrentUserProfile -ApplicationName $ApplicationName).id

        # process followed playlists
        foreach ($playlist in $Backup.followed_playlists) {
            Add-FollowedPlaylist -Id $playlist.id -Public $playlist.public -ApplicationName $ApplicationName
        }

        # process my playlists
        $MyPlaylists = Get-CurrentUserPlaylists -ApplicationName $ApplicationName
        foreach ($playlist in $Backup.my_playlists) {
            # if playlist with this id exists
            if ($MyPlaylists.id -contains $playlist.id) {
                $Id = $playlist.id
            }
            # elseif playlist with this name exists
            elseif ($MyPlaylists.name -contains $playlist.name) {
                $Id = $MyPlaylists.Where( { $_.name -eq $playlist.name })[0].id
            }
            # else playlist doesn't exists
            else {
                # create
                $Id = (New-Playlist -UserId $MyId -Name $playlist.name -Public $playlist.public -Collaborative $playlist.collaborative -Description $playlist.description -ApplicationName $ApplicationName).id
            }
            # set tracks
            Set-PlaylistItems -Id $Id -Uris $playlist.tracks -ApplicationName $ApplicationName | Out-Null
            # set image
            if ($playlist.image) { Send-PlaylistCoverImage -Id $Id -ImageBase64 $playlist.image | Out-Null }
        }
    }

    if ($Type -contains 'FollowedArtists' -or $Type -contains 'All') {
        if ($Backup.followed_artists) {
            Add-FollowedArtist -Id $Backup.followed_artists.id -ApplicationName $ApplicationName
        }
    }

    if ($Type -contains 'SavedAlbums' -or $Type -contains 'All') {
        if ($Backup.saved_albums) {
            Add-CurrentUserSavedAlbum -Id $Backup.saved_albums.id -ApplicationName $ApplicationName
        }
    }

    if ($Type -contains 'SavedShows' -or $Type -contains 'All') {
        if ($Backup.saved_shows) {
            Add-CurrentUserSavedShow -Id $Backup.saved_shows.id -ApplicationName $ApplicationName
        }
    }

    if ($Type -contains 'SavedTracks' -or $Type -contains 'All') {
        if ($Backup.saved_tracks) {
            Add-CurrentUserSavedTrack -Id $Backup.saved_tracks.id -ApplicationName $ApplicationName
        }
    }

    Write-Host -BackgroundColor Magenta -ForegroundColor White 'It may take few minutes before library items appears. Please be patient.'
}