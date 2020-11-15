<#
    .SYNOPSIS
        Get Spotify catalog information for one or more artists based on their Spotify IDs.
    .EXAMPLE
        PS C:\> Get-Artist -Id 'blahblahblah'
        Retrieves an artist from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Artist -Id 'blahblahblah','blahblahblah2'
        Retrieves both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Artist
        Retrieves both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Id
        One or more Artist Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Artist {
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

        $Uri = 'https://api.spotify.com/v1/artists?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.artists
    }
}