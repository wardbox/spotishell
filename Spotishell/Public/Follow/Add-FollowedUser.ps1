<#
    .SYNOPSIS
        Add the current user as a follower of one or more other Spotify users.
    .EXAMPLE
        PS C:\> Add-FollowedUser -Id 'blahblahblah'
        Add the user with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> Add-FollowedUser -Id 'blahblahblah','blahblahblah2'
        Add both users with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Add-FollowedUser
        Add both users with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify user Ids that you want to follow
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-FollowedUser {
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

        $Uri = 'https://api.spotify.com/v1/me/following?type=user&ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}