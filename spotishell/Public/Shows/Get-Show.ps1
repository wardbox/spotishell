<#
    .SYNOPSIS
        Gets one or more shows.
    .EXAMPLE
        PS C:\> Get-Show -Id 'blahblahblah'
        Retrieves a show from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Show -Ids 'blahblahblah','blahblahblah2'
        Retrieves both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Show
        Retrieves both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Show Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Show {
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

        $Uri = 'https://api.spotify.com/v1/shows?ids=' + ($Ids[$i..($i + 49)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.shows
    }
}