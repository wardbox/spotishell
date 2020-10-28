<#
    .SYNOPSIS
        Remove the current user as a follower of a playlist.
    .EXAMPLE
        PS C:\> Remove-FollowedPlaylist -Id 'blahblahblah'
        Remove the playlist with the Id of 'blahblahblah' to follow for the user authed under the current application
    .PARAMETER Id
        The spotify Id of the playlist we want to unfollow
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Remove-FollowedPlaylist {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Delete'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/followers"

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
}