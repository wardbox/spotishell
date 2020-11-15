<#
    .SYNOPSIS
        Get Spotify catalog information for one or more albums identified by their Spotify IDs.
    .EXAMPLE
        PS C:\> Get-Album -Id 'blahblahblah'
        Retrieves an album from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Album -Id 'blahblahblah','blahblahblah2'
        Retrieves both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Album
        Retrieves both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Id
        One or more Album Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Album {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [array]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'

    for ($i = 0; $i -lt $Id.Count; $i += 20) {

        $Uri = 'https://api.spotify.com/v1/albums?ids=' + ($Id[$i..($i + 19)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.albums
    }
}