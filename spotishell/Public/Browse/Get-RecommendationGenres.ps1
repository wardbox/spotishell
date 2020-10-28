<#
    .SYNOPSIS
        Retrieve a list of available genres seed parameter values for recommendations.
    .EXAMPLE
        PS C:\> Get-RecommendationGenres
        Retrieves all recommendation genres from Spotify
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-RecommendationGenres {
    param (
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/recommendations/available-genre-seeds'
    
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.genres
}