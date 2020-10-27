<#
    .SYNOPSIS
        Seeks to the given position in the user's currently playing track.
    .EXAMPLE
        PS C:\> Invoke-SeekPositionCurrentTrack -PositionMs 120000
        Seeks current track to position 2:00
    .PARAMETER PositionMs
        The position in milliseconds to seek to. 
        Must be a positive number.
        Passing in a position that is greater than the length of the track will cause the player to start playing the next song.
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Invoke-SeekPositionCurrentTrack {
    param (
        [Parameter(Mandatory)]
        [int]
        $PositionMs,

        [string]
        $DeviceId,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/seek?position_ms=' + $PositionMs
    if ($DeviceId) { $Uri += '&device_id=' + $DeviceId }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}