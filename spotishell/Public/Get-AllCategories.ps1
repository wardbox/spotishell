function Get-AllCategories {
  <#
.SYNOPSIS
    Gets a category.
.DESCRIPTION
    Get a single category used to tag items in Spotify (on, for example, the Spotify player�s �Browse� tab).
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
  # Grabbing 2 letter country code from local info.
  $Country = ((Get-UICulture | Select-Object -Property Name).Name.ToString()).Split("-", "2")[1]
  # Grabbing 4 digit local/country code (this sets the language of the response)
  $Locale = (Get-UICulture).Name.ToString()
  $Limit = "50"
  $Offset = "0"

  $Query = "?country=$Country&locale=$Locale&limit=$Limit&offset=$Offset"

  Write-Verbose "Attempting to return all categories."
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/browse/categories" + $Query

  $Response = (Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop).categories

  # if we have to get more results because they weren't all included in the intial batch
  if ($Response.next) {
    # this is a bit messy for now, but shows the user that there were multiple calls that went above the API limit
    $ResponseArray = @()
    While ($Response.next) {
      $ResponseArray += $Response
      $Response = (Send-SpotifyCall -Method $Method -Uri $Response.next -ErrorAction Stop).categories
    }
    $ResponseArray += $Response
    return $ResponseArray
  } else {
    return $Response
  }
}