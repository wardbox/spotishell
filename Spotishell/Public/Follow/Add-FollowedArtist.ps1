<#
    .SYNOPSIS
        Add the current user as a follower of one or more artists.
    .EXAMPLE
        PS C:\> Add-FollowedArtist -Id 'blahblahblah'
        Add the artist with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> Add-FollowedArtist -Id 'blahblahblah','blahblahblah2'
        Add both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Add-FollowedArtist
        Add both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify artist Ids that you want to follow
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-FollowedArtist {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [array]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Put'

    for ($i = 0; $i -lt $Id.Count; $i += 50) {

        $Uri = 'https://api.spotify.com/v1/me/following?type=artist&ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}