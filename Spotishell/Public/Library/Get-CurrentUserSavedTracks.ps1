<#
    .SYNOPSIS
        Get a list of the songs saved in the current Spotify user's 'Your Music' library.
    .EXAMPLE
        PS C:\> Get-CurrentUserSavedTracks
        Grabs data of all saved tracks and returns them in a list
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-CurrentUserSavedTracks {
    param(
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/tracks?limit=50'

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}