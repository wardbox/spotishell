<#
    .SYNOPSIS
        Get Spotify catalog information about artists similar to a given artist. Similarity is based on analysis of the Spotify community’s listening history.
    .EXAMPLE
        PS C:\> Get-ArtistRelatedArtists -Id 'blahblahblah'
        Retrieves artists related to artist with Id of 'blahblahblah'
    .PARAMETER Id
        The Id of the artist we want to look up
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-ArtistRelatedArtists {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/artists/$Id/related-artists"

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.artists
}