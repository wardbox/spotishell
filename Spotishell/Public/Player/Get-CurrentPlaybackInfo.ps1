<#
    .SYNOPSIS
        Get information about the user's current playback state, including track, track progress, and active device.
    .EXAMPLE
        PS C:\> Get-CurrentPlaybackInfo
        Retrieves the current playback status
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-CurrentPlaybackInfo {
    param(
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/player'

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}