<#
    .SYNOPSIS
        Check to see if one or more Spotify users are following a specified playlist.
    .EXAMPLE
        PS C:\> Test-FollowedPlaylist -PlaylistId 'blahblahblah' -UserId (Get-CurrentUserProfile).id
        Check to see if the current user follows the playlist with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Test-FollowedPlaylist -PlaylistId 'blahblahblah' -UserId 'user1','user2'
        Check to see if the users 'user1' and 'user2' follow the playlist with the Id of 'blahblahblah'
    .PARAMETER PlaylistId
        The spotify Id of the playlist we want to check
    .PARAMETER UserId
        One or more User Ids that may follow the playlist
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-FollowedPlaylist {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $PlaylistId,

        [Parameter(Mandatory, ValueFromPipeline)]
        [array]
        $UserId,

        [string]
        $ApplicationName
    )

    $Method = 'Get'

    for ($i = 0; $i -lt $UserId.Count; $i += 5) {

        $Uri = "https://api.spotify.com/v1/playlists/$PlaylistId/followers/contains?ids=" + ($UserId[$i..($i + 4)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    }
}