function Get-CategoryPlaylists {
  <#
  .SYNOPSIS
    Gets a category's playlists.
  .DESCRIPTION
    Get a list of Spotify playlists tagged with a particular category.
  .EXAMPLE
    PS C:\> Get-CategoryPlaylists "toplists"
    Retrieves details on a specific category with Id "toplists"
  .PARAMETER Id
    This should be a string
    The Id of the category we want to pull info on.
  #>
  param(
    # Id
    [Parameter(Mandatory)]
    [String]
    $Id
  )

  $Limit = "50"
  $Offset = "0"

  $Query = "?&limit=$Limit&offset=$Offset"

  Write-Verbose "Attempting to return playlists that belong to category with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/browse/categories/" + $Id + "/playlists" + $Query

  $Response = (Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop).playlists

  # if we have to get more results because they weren't all included in the intial batch
  if ($Response.next) {
    # this is a bit messy for now, but shows the user that there were multiple calls that went above the API limit
    $ResponseArray = @()
    $ResponseArray += $Response
    While ($Response.next) {
      $Response = (Send-SpotifyCall -Method $Method -Uri $Response.next -ErrorAction Stop).playlists
      $ResponseArray += $Response
    }
    $ResponseArray += $Response
    return $ResponseArray
  } else {
    return $Response
  }
}