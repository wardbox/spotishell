function Get-ArtistTopTracks {
  <#
  .SYNOPSIS
    Get Spotify catalog information about an artist�s top tracks by country.
  .DESCRIPTION
    Get Spotify catalog information about an artist�s top tracks by country.
  .EXAMPLE
    PS C:\> Get-ArtistTopTracks -Id "blahblahblah" -CountryCode "US"
    Retrieves top tracks by artist with Id "blahblahblah" in the market "US"
  .PARAMETER Id
    This should be a string
    The artist's spotify Id.
  #>
  param (
    # Id of the artist we want to get information on
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  # Grabbing 2 letter country code from local info.
  $CountryCode = ((Get-UICulture | Select-Object -Property Name).Name.ToString()).Split("-", "2")[1]
  Write-Verbose "Attempting to return info on artist with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/artists/" + $Id + "/top-tracks?country=" + $CountryCode

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response.tracks
}