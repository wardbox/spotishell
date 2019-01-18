function Get-AllCategories {
  <#
.SYNOPSIS
    Gets all categories
#>

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