<#
    .SYNOPSIS
        Get the object currently being played on the user’s Spotify account.
    .EXAMPLE
        PS C:\> Get-CurrentTrack
        Retrieves the current playing track
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-CurrentTrack {
    param (
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/player/currently-playing'

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}