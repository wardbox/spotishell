function Get-RecommendationGenres {
  <#
  .SYNOPSIS
    Get genre recommendations
  .DESCRIPTION
    Retrieve a list of available genres seed parameter values for recommendations.
  .EXAMPLE
    PS C:\> Get-RecommendationGenres
    Retrieves all recommendation genres from Spotify
  #>

  $Uri = "https://api.spotify.com/v1/recommendations/available-genre-seeds"
  $Method = "Get"

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri
  return $Response.genres

}