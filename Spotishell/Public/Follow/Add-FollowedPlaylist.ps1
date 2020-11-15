<#
    .SYNOPSIS
        Add the current user as a follower of a playlist.
    .EXAMPLE
        PS C:\> Add-FollowedPlaylist -Id 'blahblahblah'
        Add the playlist with the Id of 'blahblahblah' to follow for the user authed under the current application
    .PARAMETER Id
        The spotify Id of the playlist we want to follow
    .PARAMETER Public
        If true the playlist will be included in user’s public playlists, if false it will remain private
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-FollowedPlaylist {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [bool]
        $Public,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/followers"

    $BodyHashtable = @{}
    if ($null -ne $Public) { $BodyHashtable.public = $Public }
    $Body = ConvertTo-Json $BodyHashtable -Compress

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName | Out-Null
}