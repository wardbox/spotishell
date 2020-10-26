<#
    .SYNOPSIS
        Check if one or more tracks is already saved in the current Spotify user's 'Your Music' library.
    .EXAMPLE
        PS C:\> Test-CurrentUserSavedTracks -Id 'blahblahblah'
        Check to see if the current user saved the track with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Test-CurrentUserSavedTracks -Ids 'blahblahblah','blahblahblah2'
        Check to see if the current user saved both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Test-CurrentUserSavedTracks
        Check to see if the current user saved both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Track Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-UserSavedTracks {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [Alias('Id')]
        [array]
        $Ids,

        [string]
        $ApplicationName
    )

    $Method = 'Get'

    for ($i = 0; $i -lt $Ids.Count; $i += 50) {

        $Uri = 'https://api.spotify.com/v1/me/tracks/contains?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    }
}