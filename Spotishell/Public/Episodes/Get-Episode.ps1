<#
    .SYNOPSIS
        Get Spotify catalog information for one or more episodes based on their Spotify IDs.
    .EXAMPLE
        PS C:\> Get-Episode -Id 'blahblahblah'
        Retrieves an episode from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Episode -Id 'blahblahblah','blahblahblah2'
        Retrieves both specified episodes from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Episode
        Retrieves both specified episodes from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Id
        One or more Episode Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Episode {
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

        $Uri = 'https://api.spotify.com/v1/episodes?ids=' + ($Id[$i..($i + 49)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.episodes
    }
}