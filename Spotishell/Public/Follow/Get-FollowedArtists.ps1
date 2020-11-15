<#
    .SYNOPSIS
        Get the current user’s followed artists.
    .EXAMPLE
        PS C:\> Get-FollowedArtists
        Grabs data of all followed artist and returns them in a list
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-FollowedArtists {
    param(
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/following?type=artist&limit=50'

    # build a fake Response to start the machine
    $Response = @{artists = @{next = $Uri } }

    While ($Response.artists.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.artists.next -ApplicationName $ApplicationName
        $Response.artists.items # this return items that will be aggregated with items of other loops
    }
}