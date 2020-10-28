<#
    .SYNOPSIS
        Pause playback on the user's account.
    .EXAMPLE
        PS C:\> Suspend-Playback
        Pauses playback
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Suspend-Playback {
    param (
        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/pause'
    if ($DeviceId) { $Uri += '?device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}