<#
    .SYNOPSIS
        Get a list of the playlists owned or followed by a Spotify user.
    .EXAMPLE
        PS C:\> Get-UserPlaylists -Id 'thisUserId'
        Grabs data of playlists of user with Id 'thisUserId'
    .PARAMETER Id
        Specifies the Spotify user we want to search for
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-UserPlaylists {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/users/$Id/playlists?limit=50"

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}