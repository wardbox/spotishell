<#
    .SYNOPSIS
        Reorder an item or a group of items in a playlist.
    .EXAMPLE
        PS C:\> Edit-PlaylistOrder -Id 'blahblahblah' -RangeStart 0 -InsertBefore 4
        Moves the first item to the fifth position in the playlist with id 'blahblahblah'
    .EXAMPLE
        PS C:\> Edit-PlaylistOrder -Id 'blahblahblah' -RangeStart 1 -RangeLength 2 -InsertBefore 3
        Moves the second and third items to the fourth position in the playlist with id 'blahblahblah'
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER RangeStart
        Specifies the position of the first item to be reordered.
    .PARAMETER RangeLength
        Specifies the amount of items to be reordered. Defaults to 1 if not set.
        The range of items to be reordered begins from the range_start position, and includes the range_length subsequent items.
    .PARAMETER InsertBefore
        Specifies the position where the items should be inserted.
        To reorder the items to the end of the playlist, simply set insert_before to the position after the last item.
    .PARAMETER SnapshotId
        Specifies the playlist’s snapshot ID against which you want to make the changes.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Edit-PlaylistOrder {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $RangeStart,

        [int]
        $RangeLength,

        [Parameter(Mandatory)]
        [int]
        $InsertBefore,

        [string]
        $SnapshotId,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    $BodyHashtable = @{
        range_start   = $RangeStart 
        insert_before = $InsertBefore
    }
    if ($RangeLength) { $BodyHashtable.range_length = $RangeLength }
    if ($SnapshotId) { $BodyHashtable.snapshot_id = $SnapshotId }
    $Body = ConvertTo-Json $BodyHashtable -Compress

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}