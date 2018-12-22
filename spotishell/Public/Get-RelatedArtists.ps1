function Get-RelatedArtists {
  <#
.SYNOPSIS
    Gets related artists
.DESCRIPTION
    Get Spotify catalog information about artists similar to a given artist.
.EXAMPLE
    PS C:\> Get-RelatedArtists -Id "blahblahblah"
    Retrieves artists related to artist with Id of "blahblahblah"
.PARAMETER Id
    This should be a string
    The Id of the artist we want to look up
#>
  param (
    # Id of the artist we want to look up
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  Write-Verbose "Attempting to return artists related to artist with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/artists/" + $Id + "/related-artists"

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
    return $Response.artists
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-RelatedArtists"
  }
}