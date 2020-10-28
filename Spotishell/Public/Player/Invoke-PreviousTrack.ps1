<#
    .SYNOPSIS
        Skips to previous track in the user's queue.
    .DESCRIPTION
        Note that this will always skip to the previous track, regardless of the current track’s progress.
    .EXAMPLE
        PS C:\> Invoke-PreviousTrack
        Skips to previous track
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Invoke-PreviousTrack {
    param (
        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )
    
    $Method = 'Post'
    $Uri = "https://api.spotify.com/v1/me/player/previous"
    if ($DeviceId) { $Uri += '?device_id=' + $DeviceId }
    
    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}
