<#
    .SYNOPSIS
        Delete one or more shows from current Spotify user's library.
    .EXAMPLE
        PS C:\> Remove-CurrentUserSavedShow -Id 'blahblahblah'
        Remove the saved show with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> Remove-CurrentUserSavedShow -Id 'blahblahblah','blahblahblah2'
        Remove both saved shows with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Remove-CurrentUserSavedShow
        Remove both saved shows with the Id of 'blahblahblah' for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify show Ids that you want to remove
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Remove-CurrentUserSavedShow {
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

        $Uri = 'https://api.spotify.com/v1/me/shows?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}