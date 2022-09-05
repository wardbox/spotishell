<#
    .SYNOPSIS
        Replace all the items in a playlist, overwriting its existing items.
    .EXAMPLE
        PS C:\> Set-PlaylistItems -Id 'blahblahblah'
        Empties the playlist with id 'blahblahblah'
    .EXAMPLE
        PS C:\> Set-PlaylistItems -Id 'blahblahblah' -Uris @('spotify:track:4iV5W9uYEdYUVa79Axb7Rh','spotify:track:1301WleyT98MSxVHPZCA6M')
        Put both uris in the playlist with id 'blahblahblah' (previous content of the playlist is lost)
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER Uris
        Specifies an array of the Spotify URIs to set, can be track or episode URIs.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Set-PlaylistItems {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [Parameter(ValueFromPipeline)]
        [array]
        $Uris,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    if ($Uris) {

        # process 100 first items
        $BodyHashtable = @{uris = $Uris[0..99] }
        $Body = ConvertTo-Json $BodyHashtable -Compress

        Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName

        # if there is more than 100 items add them to the end of playlist
        if ($Uris.Count -gt 100) {
            Add-PlaylistItem -Id $Id -ItemId $Uris[100..$($Uris.Count-1)] -ApplicationName $ApplicationName
        }
    }
    else {
        Send-SpotifyCall -Method $Method -Uri $Uri -Body '{"uris":[]}' -ApplicationName $ApplicationName
    }
}