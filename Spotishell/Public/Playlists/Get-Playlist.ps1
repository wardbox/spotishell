<#
    .SYNOPSIS
        Get a playlist owned by a Spotify user.
    .EXAMPLE
        PS C:\> Get-Playlist -Id 'blahblahblah'
        Retrieves a playlist with the Id of 'blahblahblah'
    .PARAMETER Id
        Specifies the playlist Id
    .PARAMETER Fields
        Filters for the query: a comma-separated list of the fields to return. If omitted, all fields are returned.
        For example, to get just the playlist’s description and URI: 'description,uri'.
        A dot separator can be used to specify non-reoccurring fields, while parentheses can be used to specify reoccurring fields within objects.
        For example, to get just the added date and user ID of the adder: 'tracks.items(added_at,added_by.id)'.
        Use multiple parentheses to drill down into nested objects.
        For example: 'tracks.items(track(name,href,album(name,href)))'.
        Fields can be excluded by prefixing them with an exclamation mark.
        For example: 'tracks.items(track(name,href,album(!name,href)))'
    .PARAMETER Market
        Specifies an ISO 3166-1 alpha-2 country code or the string from_token.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-Playlist {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $Fields,

        [string]
        $Market,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/playlists/' + $Id

    $Query = @()
    if ($Fields) { $Query += 'fields=' + $Fields }
    if ($Market) { $Query += 'market=' + $Market }

    if ($Query.Count) { $Uri += '?' + ($Query -join '&') }

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}