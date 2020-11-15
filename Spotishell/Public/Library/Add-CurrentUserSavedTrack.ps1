<#
    .SYNOPSIS
        Save one or more tracks from the current user's 'Your Music' library.
    .EXAMPLE
        PS C:\> Add-CurrentUserSavedTrack -Id 'blahblahblah'
        Save the track with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> Add-CurrentUserSavedTrack -Id 'blahblahblah','blahblahblah2'
        Save both tracks with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Add-CurrentUserSavedTrack
        Save both tracks with the Id of 'blahblahblah' for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify track Ids that you want to save
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Add-CurrentUserSavedTrack {
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

        $Uri = 'https://api.spotify.com/v1/me/tracks?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}