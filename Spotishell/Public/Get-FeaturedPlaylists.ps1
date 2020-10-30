function Get-FeaturedPlaylists {
  <#
  .SYNOPSIS
    Get featured playlists
  .DESCRIPTION
    Get a list of new album releases featured in Spotify (shown, for example, on a Spotify playerâ€™s â€œBrowseâ€� tab).
  .EXAMPLE
    PS C:\> Get-FeaturedPlaylists
    Retrieves all featured playlists
  .NOTES
    50 is the limit, it'll page through if there are more
  #>

  $Uri = "https://api.spotify.com/v1/browse/featured-playlists?limit=50"
  $Method = "Get"

  $Response = (Send-SpotifyCall -Method $Method -Uri $Uri).playlists
  if ($Response.next) {
    # this is a bit messy for now, but shows the user that there were multiple calls that went above the API limit
    $ResponseArray = @()
    While ($Response.next) {
      $ResponseArray += $Response
      $Response = (Send-SpotifyCall -Method $Method -Uri $Response.next -ErrorAction Stop).playlists
    }
    $ResponseArray += $Response
    return $ResponseArray
  } else {
    return $Response
  }
  return $ResponseArray
}