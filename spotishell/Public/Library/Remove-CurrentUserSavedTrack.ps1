<#
    .SYNOPSIS
        Remove one or more tracks from the current user's 'Your Music' library.
    .EXAMPLE
        PS C:\> Remove-CurrentUserSavedTrack -Id 'blahblahblah'
        Remove the saved track with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> Remove-CurrentUserSavedTrack -Ids 'blahblahblah','blahblahblah2'
        Remove both saved tracks with the Id of 'blahblahblah' for the user authed under the current Application
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Remove-CurrentUserSavedTrack
        Remove both saved tracks with the Id of 'blahblahblah' for the user authed under the current Application
    .PARAMETER Ids
        One or more Spotify track Ids that you want to remove
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Remove-CurrentUserSavedTrack {
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

        $Uri = 'https://api.spotify.com/v1/me/tracks?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName | Out-Null
    }
}