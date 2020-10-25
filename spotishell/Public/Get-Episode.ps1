<#
    .SYNOPSIS
        Gets one or more episodes.
    .DESCRIPTION
        Gets one or more episodes with specific Spotify Ids
    .EXAMPLE
        PS C:\> Get-Episode -Id 'blahblahblah'
        Retrieves an episode from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Episode -Ids 'blahblahblah','blahblahblah2'
        Retrieves both specified episodes from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Episode
        Retrieves both specified episodes from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Episode Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Episode {
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

        $Uri = 'https://api.spotify.com/v1/episodes?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.episodes
    }
}