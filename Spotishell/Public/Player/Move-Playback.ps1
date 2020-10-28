<#
    .SYNOPSIS
        Transfer playback to a new device and determine if it should start playing.
    .EXAMPLE
        PS C:\> Move-Playback -DeviceId '6ea768bcdce0c0be68b0905d8afe500107abea70'
        Transfer playback to the device with id '6ea768bcdce0c0be68b0905d8afe500107abea70'
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER Play
        Specifies if it should start playing.
        $true: ensure playback happens on new device.
        $false or not provided: keep the current playback state.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Move-Playback {
    param (
        [Parameter(Mandatory)]
        [string]
        $DeviceId,

        [bool]
        $Play,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player'

    $BodyHashtable = @{device_ids = @($DeviceId) }
    if ($ContextUri) { $BodyHashtable.play = $Play }

    $Body = ConvertTo-Json $BodyHashtable -Compress

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}