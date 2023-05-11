<#
    .SYNOPSIS
        Toggle shuffle on or off for user's playback.
    .EXAMPLE
        PS C:\> Set-ShufflePlayback -State $true
        Set Shuffle mode ON
    .PARAMETER State
        Specifies the shuffle mode to set
        $true : Shuffle user's playback
        $false : Do not shuffle user's playback.
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Set-ShufflePlayback {
    param (
        [Parameter(Mandatory)]
        [bool]
        $State,

        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/shuffle?state=' + $State.ToString().ToLower()
    if ($DeviceId) { $Uri += '&device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}