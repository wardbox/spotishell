<#
    .SYNOPSIS
        Get one or more categories used to tag items in Spotify (on, for example, the Spotify player’s “Browse” tab).
    .EXAMPLE
        PS C:\> Get-Category -Id 'toplists'
        Retrieves details on a specific category with Id 'toplists'
    .EXAMPLE
        PS C:\> Get-Category
        Retrieves details on all categories
    .PARAMETER Id
        Specifies the category's Id we want to pull info on.
    .PARAMETER Country
        Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
        Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
        Ex : FR
    .PARAMETER Locale
        Specifies the desired language
        Uses an "ISO 639-1" language code and an "ISO 3166-1 alpha-2" country code, joined by an underscore
        Ex : es_MX    meaning Spanish (Mexico)
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Category {
    param(
        [String]
        $Id,

        [String]
        $Country,

        [String]
        $Locale,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/browse/categories'

    $Query = @()
    if ($Country) { $Query += 'country=' + $Country }
    if ($Locale) { $Query += 'locale=' + $Locale }

    if ($Id) {
        $Uri += '/' + $Id
        if ($Query.Count) { $Uri += '?' + ($Query -join '&') }

        Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    }
    else {

        $Uri += '?limit=50'
        if ($Query.Count) { $Uri += '&' + ($Query -join '&') }

        # build a fake Response to start the machine
        $Response = @{ 
            categories = @{next = $Uri }
        }

        While ($Response.categories.next) {
            $Response = Send-SpotifyCall -Method $Method -Uri $Response.categories.next -ApplicationName $ApplicationName
            $Response.categories.items # this return items that will be aggregated with items of other loops
        }
    }
}