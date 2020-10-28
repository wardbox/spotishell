<#
    .SYNOPSIS
        Check if current user follows one or more artists
    .EXAMPLE
        PS C:\> Test-FollowedArtist -Id "blahblahblah"
        Check to see if the current user follows the artist with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Test-FollowedArtist -Ids 'blahblahblah','blahblahblah2'
        Check to see if the current user follows both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Test-FollowedArtist
        Check to see if the current user follows both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Artist Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-FollowedArtist {
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

        $Uri = 'https://api.spotify.com/v1/me/following/contains?type=artist&ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    }
}