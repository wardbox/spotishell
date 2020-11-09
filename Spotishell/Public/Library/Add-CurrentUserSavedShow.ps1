<#
    .SYNOPSIS
        Save one or more shows from current Spotify user's library.
    .EXAMPLE
        PS C:\> Add-CurrentUserSavedShow -Id 'blahblahblah'
        Save the show with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> Add-CurrentUserSavedShow -Id 'blahblahblah','blahblahblah2'
        Save both shows with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Add-CurrentUserSavedShow
        Save both shows with the Id of 'blahblahblah' for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify show Ids that you want to save
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-CurrentUserSavedShow {
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

        $Uri = 'https://api.spotify.com/v1/me/shows?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}