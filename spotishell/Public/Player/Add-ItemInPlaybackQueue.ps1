
<#
    .SYNOPSIS
        Add an item to the end of the user's current playback queue.
    .EXAMPLE
        PS C:\> Add-ItemInPlaybackQueue
        Skips to next song for user with username "blahblah"
    .PARAMETER ItemUri
        The uri of the item to add to the queue. Must be a track or an episode uri.
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-ItemInPlaybackQueue {
    param (
        [Parameter(Mandatory)]
        [string]
        $ItemUri,

        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )
  
    $Method = 'Post'
    $Uri = 'https://api.spotify.com/v1/me/player/queue?uri=' + $ItemUri
    if ($DeviceId) { $Uri += '&device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
}
