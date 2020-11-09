<#
    .SYNOPSIS
        Remove one or more tracks from the current user's 'Your Music' library.
    .EXAMPLE
        PS C:\> Remove-CurrentUserSavedTrack -Id 'blahblahblah'
        Remove the saved track with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> Remove-CurrentUserSavedTrack -Id 'blahblahblah','blahblahblah2'
        Remove both saved tracks with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Remove-CurrentUserSavedTrack
        Remove both saved tracks with the Id of 'blahblahblah' for the user authed under the current Application
    .PARAMETER Id
        One or more Spotify track Ids that you want to remove
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Remove-CurrentUserSavedTrack {
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

        $Uri = 'https://api.spotify.com/v1/me/tracks?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}