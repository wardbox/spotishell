<#
    .SYNOPSIS
        Get a playlist owned by a Spotify user.
    .EXAMPLE
        PS C:\> Get-PlaylistItems -Id 'blahblahblah'
        Retrieves tracks or episodes of the playlist with the Id of 'blahblahblah'
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER Field
        Filters for the query: a comma-separated list of the fields to return. If omitted, all fields are returned.
        For example, to get just the total number of items and the request limit: 'total,limit'
        A dot separator can be used to specify non-reoccurring fields, while parentheses can be used to specify reoccurring fields within objects.
        For example, to get just the added date and user ID of the adder: 'items(added_at,added_by.id)'.
        Use multiple parentheses to drill down into nested objects.
        For example: 'items(track(name,href,album(name,href)))'.
        Fields can be excluded by prefixing them with an exclamation mark.
        For example: 'items.track.album(!external_urls,images)'
    .PARAMETER Market
        Specifies an ISO 3166-1 alpha-2 country code or the string from_token.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-PlaylistItems {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $Field,

        [string]
        $Market,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/tracks?limit=100"

    $Query = @()
    if ($Field) { $Query += 'fields=' + $Field }
    if ($Market) { $Query += 'market=' + $Market }

    if ($Query.Count) { $Uri += '?' + ($Query -join '&') }

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}