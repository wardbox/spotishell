<#
    .SYNOPSIS
        Gets one or more artists.
    .DESCRIPTION
        Gets one or more artists with specific Spotify Ids
    .EXAMPLE
        PS C:\> Get-Artist -Id "blahblahblah"
        Retrieves an artist from Spotify with the Id of "blahblahblah"
    .EXAMPLE
        PS C:\> Get-Artist -Ids 'blahblahblah','blahblahblah2'
        Retrieves both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Artist
        Retrieves both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Artist Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Artist {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        # [ValidateNotNullOrEmpty()]
        [Alias('Id')]
        [array]
        $Ids,

        [string]
        $ApplicationName
    )

    $Method = 'Get'

    for ($i = 0; $i -lt $Ids.Count; $i += 50) {

        $Uri = 'https://api.spotify.com/v1/artists?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.artists
    }
}