<#
    .SYNOPSIS
        Remove one or more items from a user's playlist.
    .EXAMPLE
        PS C:\> Remove-PlaylistItems -Id 'myPlaylistId' -Track @(@{uri = 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh' }, @{uri = 'spotify:track:1301WleyT98MSxVHPZCA6M' })
        Removes all occurrences of both tracks by specifying only uris in playlist with Id 'myPlaylistId'
    .EXAMPLE
        PS C:\> Remove-PlaylistItems -Id 'myPlaylistId' -Track @(@{uri = 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh'; positions = @(0, 3) }, @{uri = 'spotify:track:1301WleyT98MSxVHPZCA6M' ; positions = @(7) })
        Removes specific occurrence of both tracks by specifying both the uris and items positions in the playlist with Id 'myPlaylistId'
    .EXAMPLE
        PS C:\> Remove-PlaylistItems -Id 'myPlaylistId' -Track @(@{uri = 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh' }) -SnapshotId 'mySuperPlaylistSnapshot'
        Removes all occurrences of both tracks in the specific snapshot with Id 'mySuperPlaylistSnapshot' of the playlist
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER Track
        An array of objects containing Spotify URIs of the tracks and episodes to remove
        It may contains specific positions of each tracks/episodes to remove (zero-indexed)
    .PARAMETER SnapshotId
        The playlist's snapshot ID against which you want to make the changes.
        The API will validate that the specified items exist and in the specified positions and make the changes, even if more recent changes have been made to the playlist.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Remove-PlaylistItems {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [Parameter(Mandatory, ValueFromPipeline)]
        [array]
        $Track,

        [string]
        $SnapshotId,

        [string]
        $ApplicationName
    )

    $Method = 'Delete'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    for ($i = 0; $i -lt $Track.Count; $i += 100) {

        $BodyHashtable = @{tracks = $Track[$i..($i + 99)] }
        if ($SnapshotId) { $BodyHashtable.snapshot_id = $SnapshotId }
        $Body = ConvertTo-Json $BodyHashtable -Compress

        Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
    }
}
