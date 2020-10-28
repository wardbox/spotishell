<#
    .SYNOPSIS
        Get Spotify catalog information about an artist’s top tracks by country.
    .EXAMPLE
        PS C:\> Get-ArtistTopTracks -Id 'blahblahblah'
        Retrieves top tracks by artist with Id 'blahblahblah' in your country
    .EXAMPLE
        PS C:\> Get-ArtistTopTracks -Id 'blahblahblah' -Country 'US'
        Retrieves top tracks by artist with Id 'blahblahblah' in the market 'US'
    .PARAMETER Id
        The artist's Spotify Id
    .PARAMETER Country
        Specifies the country (ISO 3166-1 Alpha-2) of top tracks listing. (otherwise Country of Spotify account)   
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-ArtistTopTracks {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $Country = 'from_token',

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/artists/$Id/top-tracks?country=" + $Country

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.tracks
}