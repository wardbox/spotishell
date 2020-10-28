<#
    .SYNOPSIS
        Get Spotify catalog information for one or more tracks based on their Spotify IDs.
    .EXAMPLE
        PS C:\> Get-Track -Id 'blahblahblah'
        Retrieves an track from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Track -Ids 'blahblahblah','blahblahblah2'
        Retrieves both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Track
        Retrieves both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Track Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Track {
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

        $Uri = 'https://api.spotify.com/v1/tracks?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.tracks
    }
}