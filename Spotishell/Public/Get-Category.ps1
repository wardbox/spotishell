function Get-Category {
  <#
  .SYNOPSIS
    Gets a category.
  .DESCRIPTION
    Get a single category used to tag items in Spotify (on, for example, the Spotify player’s “Browse” tab).
  .EXAMPLE
    PS C:\> Get-Category "toplists"
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

  Write-Verbose "Attempting to return all categories."
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/browse/categories/" + "$Id"

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}