<#
    .SYNOPSIS
        Get the current image associated with a specific playlist.
    .EXAMPLE
        PS C:\> Get-PlaylistCoverImage -Id 'thisPlaylistId'
        Grabs image information of playlists with Id 'thisPlaylistId'
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-PlaylistCoverImage {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/images"

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}