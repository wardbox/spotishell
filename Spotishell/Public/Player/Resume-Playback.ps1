<#
    .SYNOPSIS
        Resume current playback on the user's active device.
    .EXAMPLE
        PS C:\> Resume-Playback
        Resumes current playback on the user's active device
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Resume-Playback {
    param (
        [Parameter(ValueFromPipeline)]
        [array]
        $DeviceId,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/play'
    if ($DeviceId) { $Uri += '?device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}