<#
    .SYNOPSIS
        Gets one or more albums.
    .DESCRIPTION
        Gets one or more albums with specific spotify Ids
    .EXAMPLE
        PS C:\> Get-Album -Id 'blahblahblah'
        Retrieves an album from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-Album -Ids 'blahblahblah','blahblahblah2'
        Retrieves both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-Album
        Retrieves both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Album Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Album {
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

    for ($i = 0; $i -lt $Ids.Count; $i += 20) {

        $Uri = 'https://api.spotify.com/v1/albums?ids=' + ($Ids[$i..($i + 19)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.albums
    }
}