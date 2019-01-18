function Get-NewReleases {
  <#
  .SYNOPSIS
    Get new releases
  .DESCRIPTION
    Get a list of new album releases featured in Spotify (shown, for example, on a Spotify player’s “Browse” tab).
  .EXAMPLE
    PS C:\> Get-NewReleases
    Retrieves all new releases
  #>

  $Uri = "https://api.spotify.com/v1/browse/new-releases?limit=50"
  $Method = "Get"

  $Response = (Send-SpotifyCall -Method $Method -Uri $Uri).albums
  if ($Response.next) {
    # this is a bit messy for now, but shows the user that there were multiple calls that went above the API limit
    $ResponseArray = @()
    While ($Response.next) {
      $ResponseArray += $Response
      $Response = (Send-SpotifyCall -Method $Method -Uri $Response.next -ErrorAction Stop).albums
    }
    $ResponseArray += $Response
    return $ResponseArray
  } else {
    return $Response
  }
  return $ResponseArray
}