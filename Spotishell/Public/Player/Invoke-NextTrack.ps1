<#
    .SYNOPSIS
        Skips to next track in the user's queue.
    .EXAMPLE
        PS C:\> Invoke-NextTrack
        Skips to next track
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Invoke-NextTrack {
    param (
        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )
    
    $Method = 'Post'
    $Uri = "https://api.spotify.com/v1/me/player/next"
    if ($DeviceId) { $Uri += '?device_id=' + $DeviceId }
    
    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}
