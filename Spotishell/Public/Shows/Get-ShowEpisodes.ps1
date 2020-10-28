<#
    .SYNOPSIS
        Get Spotify catalog information about a show's episodes. Optional parameters can be used to limit the number of episodes returned.
    .EXAMPLE
        PS C:\> Get-ShowEpisodes -Id 'blahblahblah'
        Retrieves show episodes from spotify show with the Id of "blahblahblah"
    .PARAMETER Id
        Specifies the Show Id
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-ShowEpisodes {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = "Get"
    $Uri = "https://api.spotify.com/v1/shows/$Id/episodes?limit=50"

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}