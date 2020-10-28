<#
    .SYNOPSIS
        Get a list of Spotify playlists tagged with a particular category.
    .EXAMPLE
        PS C:\> Get-CategoryPlaylists 'toplists'
        Retrieves details on a specific category with Id "toplists"
    .PARAMETER Id
        The Id of the category we want to pull info on.
    .PARAMETER Country
        Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
        Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
        Ex : FR
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-CategoryPlaylists {
    param(
        [Parameter(Mandatory)]
        [String]
        $Id,

        [string]
        $Country,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/browse/categories/$Id/playlists?limit=50'
    if ($Country) { $Uri += '&country=' + $Country }

    # build a fake Response to start the machine
    $Response = @{ 
        playlists = @{next = $Uri }
    }
    
    While ($Response.playlists.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.playlists.next -ApplicationName $ApplicationName
        $Response.playlists.items # this return items that will be aggregated with items of other loops
    }
}