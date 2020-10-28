<#
    .SYNOPSIS
        Get information about a user's available devices.
    .EXAMPLE
        PS C:\> Get-AvailableDevices
        Retrieves list of available devices
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-AvailableDevices {
    param(
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/player/devices'

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.devices
}