<#
    .SYNOPSIS
        Add one or more items to a user's playlist.
    .EXAMPLE
        PS C:\> Add-PlaylistItem -Id 'myPlaylistId' -ItemId '4iV5W9uYEdYUVa79Axb7Rh'
        Add the track with the Id of '4iV5W9uYEdYUVa79Axb7Rh' to the playlist with Id 'myPlaylistId'
    .EXAMPLE
        PS C:\> Add-PlaylistItem -Id 'myPlaylistId' -ItemId 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh'
        Add the track using a full Spotify URI (also supported)
    .EXAMPLE
        PS C:\> Add-PlaylistItem -Id 'myPlaylistId' -ItemId '4iV5W9uYEdYUVa79Axb7Rh','1301WleyT98MSxVHPZCA6M'
        Add multiple tracks to the playlist
    .EXAMPLE
        PS C:\> Add-PlaylistItem -Id 'myPlaylistId' -ItemId '5CfCWKI5pZ28U0uOzXkDHe' -ItemType episode
        Add a podcast episode to the playlist
    .PARAMETER Id
        The Spotify ID for the playlist.
    .PARAMETER ItemId
        Specifies the Spotify IDs or URIs to add. Can be track or episode IDs/URIs.
        Plain IDs will be automatically converted to URIs using the ItemType parameter.
        Full URIs (e.g., 'spotify:track:xxx') are passed through unchanged.
    .PARAMETER ItemType
        Specifies the type of item when using plain IDs. Valid values are 'track' or 'episode'.
        Defaults to 'track'. Ignored when passing full Spotify URIs.
    .PARAMETER Position
        Specifies the position to insert the items, a zero-based index.
        If omitted, the items will be appended to the playlist.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-PlaylistItem {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [array]
        $ItemId,

        [ValidateSet('track', 'episode')]
        [string]
        $ItemType = 'track',

        [int]
        $Position,

        [string]
        $ApplicationName
    )

    $Method = 'Post'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    # Convert plain IDs to URIs, pass through existing URIs unchanged
    # Use @() to ensure result is always an array (single items would otherwise be strings)
    $ProcessedItems = @($ItemId | ForEach-Object {
        if ($_ -match '^spotify:(track|episode):') {
            $_  # Already a URI, use as-is
        }
        else {
            "spotify:${ItemType}:$_"  # Convert ID to URI
        }
    })

    for ($i = 0; $i -lt $ProcessedItems.Count; $i += 100) {

        $BodyHashtable = @{uris = $ProcessedItems[$i..($i + 99)] }
        if ($Position) { $BodyHashtable.position = ($Position + $i + 1) }

        $Body = ConvertTo-Json $BodyHashtable -Compress

        Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
    }
}