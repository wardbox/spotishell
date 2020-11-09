<#
    .SYNOPSIS
        Add one or more items to a user's playlist.
    .EXAMPLE
        PS C:\> Add-PlaylistItem -Id 'myPlaylistId' -ItemId 'blahblahblah'
        Add the Item with the Id of 'blahblahblah' to the playlist with Id 'myPlaylistId'
    .EXAMPLE
        PS C:\> Add-PlaylistItem -Id 'myPlaylistId' -ItemId 'blahblahblah','blahblahblah2'
        Add both items with the Id of 'blahblahblah' to the playlist with Id 'myPlaylistId'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Add-PlaylistItem -Id 
        Add both items with the Id of 'blahblahblah' to the playlist with Id 'myPlaylistId'
    .PARAMETER Id
        The Spotify ID for the playlist.
    .PARAMETER ItemId
        Specifies the list of Spotify URIs to add, can be track or episode URIs.
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

        [int]
        $Position,

        [string]
        $ApplicationName
    )

    $Method = 'Post'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    for ($i = 0; $i -lt $ItemId.Count; $i += 100) {

        $BodyHashtable = @{uris = $ItemId[$i..($i + 99)] }
        if ($Position) { $BodyHashtable.position = ($Position + $i + 1) }
    
        $Body = ConvertTo-Json $BodyHashtable -Compress
        
        Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
    }
}