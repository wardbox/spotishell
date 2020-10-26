    <#
    .SYNOPSIS
        Unfollow an User
    .EXAMPLE
        PS C:\> Remove-FollowedUser -Id 'blahblahblah'
        Remove the user with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> Remove-FollowedUser -Ids 'blahblahblah','blahblahblah2'
        Remove both users with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Remove-FollowedUser
        Remove both users with the Id of 'blahblahblah' to follow for the user authed under the current Application
    .PARAMETER Ids
        One or more Spotify user Ids that you want to unfollow
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
    #>
function Remove-FollowedUser {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [Alias('Id')]
        [array]
        $Ids,

        [string]
        $ApplicationName
    )

    $Method = 'Delete'

    for ($i = 0; $i -lt $Ids.Count; $i += 50) {

        $Uri = 'https://api.spotify.com/v1/me/following?type=user&ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}