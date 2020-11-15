<#
    .SYNOPSIS
        Get Spotify catalog information about an album’s tracks.
    .EXAMPLE
        PS C:\> Get-AlbumTracks -Id 'blahblahblah'
        Retrieves album tracks from spotify album with the Id of "blahblahblah"
    .PARAMETER Id
        Specifies the album Id
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-AlbumTracks {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/albums/$Id/tracks?limit=50"

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}