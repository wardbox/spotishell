<#
    .SYNOPSIS
        Get a list of new album releases featured in Spotify (shown, for example, on a Spotify player’s “Browse” tab).
    .EXAMPLE
        PS C:\> Get-NewReleases
        Retrieves all new releases
    .PARAMETER Country
        Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
        If omitted, the returned items will be relevant to all countries.
        Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
        Ex : FR
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-NewReleases {
    param(
        [string]
        $Country,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/browse/new-releases?limit=50'
    if ($Country) { $Uri += '&country=' + $Country }

    # build a fake Response to start the machine
    $Response = @{ 
        albums = @{next = $Uri }
    }
        
    While ($Response.albums.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.albums.next -ApplicationName $ApplicationName
        $Response.albums.items # this return items that will be aggregated with items of other loops
    }
}