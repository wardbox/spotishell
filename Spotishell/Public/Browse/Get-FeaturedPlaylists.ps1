<#
    .SYNOPSIS
        Get a list of Spotify featured playlists (shown, for example, on a Spotify player’s ‘Browse’ tab).
    .EXAMPLE
        PS C:\> Get-FeaturedPlaylists
        Retrieves all featured playlists
    .PARAMETER Country
        Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
        If omitted, the returned items will be relevant to all countries.
        Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
        Ex : FR
    .PARAMETER Locale
        Specifies the desired language
        Uses an "ISO 639-1" language code and an "ISO 3166-1 alpha-2" country code, joined by an underscore
        Ex : es_MX    meaning Spanish (Mexico)
    .PARAMETER Timestamp
        Specifies the user’s local time to get results tailored for that specific date and time in the day.    
        uses ISO 8601 format: yyyy-MM-ddTHH:mm:ss. 
        Ex : 2014-10-23T09:00:00
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-FeaturedPlaylists {
    param(
        [String]
        $Country,

        [String]
        $Locale,

        [string]
        $Timestamp,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/browse/featured-playlists?limit=50'
    if ($Country) { $Uri += '&country=' + $Country }
    if ($Locale) { $Uri += '&locale=' + $Locale }
    if ($Timestamp) { $Uri += '&timestamp=' + $Timestamp }

    # build a fake Response to start the machine
    $Response = @{ 
        playlists = @{next = $Uri }
    }
    
    While ($Response.playlists.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.playlists.next -ApplicationName $ApplicationName
        $Response.playlists.items # this return items that will be aggregated with items of other loops
    }
}