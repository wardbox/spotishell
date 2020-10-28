<#
    .SYNOPSIS
        Replace the image used to represent a specific playlist.
    .EXAMPLE
        PS C:\> Set-PlaylistItems -Id 'blahblahblah'
        Empties the playlist with id 'blahblahblah'
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER ImagePath
        Path to a JPEG Image file to send.  (~190KB max size)
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Send-PlaylistCoverImage {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [Parameter(Mandatory)]
        [string]
        $ImagePath,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/images"

    $Body = [Convert]::ToBase64String((Get-Content $ImagePath -Encoding Byte))

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}