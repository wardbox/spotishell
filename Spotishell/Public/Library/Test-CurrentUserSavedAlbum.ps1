<#
    .SYNOPSIS
        Check if one or more albums is already saved in the current Spotify user's 'Your Music' library.
    .EXAMPLE
        PS C:\> Test-CurrentUserSavedAlbum -Id 'blahblahblah'
        Check to see if the current user saved the album with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Test-CurrentUserSavedAlbum -Ids 'blahblahblah','blahblahblah2'
        Check to see if the current user saved both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Test-CurrentUserSavedAlbum
        Check to see if the current user saved both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Album Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-CurrentUserSavedAlbum {
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

        $Uri = 'https://api.spotify.com/v1/me/albums/contains?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    }
}