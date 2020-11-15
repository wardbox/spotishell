<#
    .SYNOPSIS
        Remove the current user as a follower of one or more artists.
    .EXAMPLE
        PS C:\> Remove-FollowedArtist -Id 'blahblahblah'
        Remove the artist with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> Remove-FollowedArtist -Id 'blahblahblah','blahblahblah2'
        Remove both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Remove-FollowedArtist
        Remove both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify artist Ids that you want to unfollow
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Remove-FollowedArtist {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [array]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Delete'

    for ($i = 0; $i -lt $Id.Count; $i += 50) {

        $Uri = 'https://api.spotify.com/v1/me/following?type=artist&ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}