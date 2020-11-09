<#
    .SYNOPSIS
        Check if one or more shows is already saved in the current Spotify user's library.
    .EXAMPLE
        PS C:\> Test-CurrentUserSavedShow -Id 'blahblahblah'
        Check to see if the current user saved the show with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Test-CurrentUserSavedShow -Id 'blahblahblah','blahblahblah2'
        Check to see if the current user saved both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Test-CurrentUserSavedShow
        Check to see if the current user saved both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Id
        One or more Show Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-CurrentUserSavedShow {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [array]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'

    for ($i = 0; $i -lt $Id.Count; $i += 50) {

        $Uri = 'https://api.spotify.com/v1/me/shows/contains?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    }
}