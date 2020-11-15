<#
    .SYNOPSIS
        Set the repeat mode for the user's playback. Options are repeat-track, repeat-context, and off.
    .EXAMPLE
        PS C:\> Set-RepeatMode -State Track
        Set Repeat mode on current track
    .PARAMETER State
        Specifies the repeat mode to set
        Track will repeat the current track.
        Context will repeat the current context.
        Off will turn repeat off.
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Set-RepeatMode {
    param (
        [Parameter(Mandatory)]
        [ValidateSet('Track', 'Context', 'Off')]
        [string]
        $State,

        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/repeat?state=' + $State.ToLower()
    if ($DeviceId) { $Uri += '&device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}