<#
    .SYNOPSIS
        Get Spotify Catalog information about albums, artists, playlists, tracks, shows or episodes that match a keyword string.
    .EXAMPLE
        PS C:\> Search-Item -Query 'Adam Tell' -Type Artist
        Will search for just artists containing both words 'Adam' and 'Tell'
    .EXAMPLE
        PS C:\> Search-Item -Query 'Party' -Type All
        Will search for anything named 'Party'.
    .PARAMETER Query
        Specifies the Search query keywords and optional field filters and operators.
        Keyword matching: Matching of search keywords is not case-sensitive. Operators, however, should be specified in uppercase.
            Unless surrounded by double quotation marks, keywords are matched in any order.
        Operator: The operator NOT can be used to exclude results.
            the OR operator can be used to broaden the search
        Field filters: By default, results are returned when a match is found in any field of the target object type.
            Searches can be made more specific by specifying an album, artist or track field filter.
        To limit the results to a particular year, use the field filter year with album, artist, and track searches.
        To retrieve only albums released in the last two weeks, use the field filter tag:new in album searches
        More details and exemple here : https://developer.spotify.com/documentation/web-api/reference/search/search/
    .PARAMETER Type
        A list of item types to search across.
        Valid types are: All, Album, Artist, Playlist, Track, Show and Episode
    .PARAMETER Market
        An ISO 3166-1 alpha-2 country code or the string from_token.
        If a country code is specified, only artists, albums, and tracks with content that is playable in that market is returned.
    .PARAMETER IncludeExternalAudio
        Specifies to include any relevant audio content that is hosted externally in the response.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Search-Item {
    param (
        [Parameter(Mandatory)]
        [string]
        $Query,

        [Parameter(Mandatory)]
        [ValidateSet('All', 'Album', 'Artist', 'Playlist', 'Track', 'Show', 'Episode')]
        [array]
        $Type,

        [string]
        $Market,

        [switch]
        $IncludeExternalAudio,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.Spotify.com/v1/search?q=' + [System.Web.HttpUtility]::UrlEncode($Query)
    if ($Type -contains 'All') {
        $Uri += '&type=album%2Cartist%2Cplaylist%2Ctrack%2Cshow%2Cepisode'
    }
    else {
        $Uri += '&type=' + ($Type.ToLower() -join '%2C')
    }
    if ($Market) { $Uri += '&market=' + $Market }
    if ($IncludeExternalAudio) { $Uri += '&include_external=audio' }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}