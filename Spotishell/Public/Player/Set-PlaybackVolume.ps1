<#
    .SYNOPSIS
        Set the volume for the user's current playback device.
    .EXAMPLE
        PS C:\> Set-PlaybackVolume -VolumePercent 70
        Sets playback volume to 70
    .PARAMETER VolumePercent
        The volume to set. (0-100)
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Set-PlaybackVolume {
    param (
        [Parameter(Mandatory)]
        [ValidateRange(0, 100)]
        [int]
        $VolumePercent,
    
        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )
    
    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/volume?volume_percent=' + $VolumePercent
    if ($DeviceId) { $Uri += '&device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}