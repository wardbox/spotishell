<#
    .SYNOPSIS
        Start a new context on the user's active device.
    .EXAMPLE
        PS C:\> Start-Playback -TrackUris @('spotify:track:4juzduULFJiZVIcrC1tkxE')
        Start playback of Banquet track
    .EXAMPLE
        PS C:\> Start-Playback -DeviceId ((Get-AvailableDevices)[0].id) -TrackUris @('spotify:track:4juzduULFJiZVIcrC1tkxE')
        Start playback of Banquet track on first available device
    .PARAMETER DeviceId
        The id of the device this command is targeting.
        If not supplied, the user's currently active device is the target.
    .PARAMETER ContextUri
        Specifies the Spotify URI of the context to play.
        Valid contexts are albums, artists, playlists.
    .PARAMETER TrackUris
        Specifies an array of track URIs to play
    .PARAMETER OffsetPosition
        Indicates from where in the context playback should start.
        It's zero based.
        Only available when ContextUri corresponds to an album or playlist object, or when the TrackUris parameter is used.
    .PARAMETER OffsetUri
        Indicates from where in the context playback should start.
        It's representing the uri of the item to start at
        Only available when ContextUri corresponds to an album or playlist object, or when the TrackUris parameter is used.
    .PARAMETER PositionMs
        Indicates from what position to start playback.
        Passing in a position that is greater than the length of the track will cause the player to start playing the next song.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Start-Playback {
    param (
        [string]
        $DeviceId,
    
        [Parameter(Mandatory, ParameterSetName = 'Context')]
        [string]
        $ContextUri,
    
        [Parameter(Mandatory, ParameterSetName = 'Tracks')]
        [Array]
        $TrackUris,

        [int]
        $OffsetPosition,

        [string]
        $OffsetUri,

        [int]
        $PositionMs,

        [string]
        $ApplicationName
    )
    
    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/me/player/play'
    if ($DeviceId) { $Uri += '?device_id=' + $DeviceId }
    
    $BodyHashtable = @{}
    if ($ContextUri) { $BodyHashtable.context_uri = $ContextUri }
    if ($TrackUris) { $BodyHashtable.uris = $TrackUris }
    if ($OffsetPosition) { $BodyHashtable.offset = @{position = $OffsetPosition } }
    if ($OffsetUri) { $BodyHashtable.offset = @{uri = $OffsetUri } }
    if ($PositionMs) { $BodyHashtable.position_ms = $PositionMs }

    $Body = ConvertTo-Json $BodyHashtable -Compress

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}