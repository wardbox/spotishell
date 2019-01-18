function Get-UserTopArtists {
  <#
  .SYNOPSIS
    Get top artists for user
  .EXAMPLE
    PS C:\> Get-UserTopArtists -Range "long"
    Gets top artists for user over several years
  .PARAMETER Range
    Long (calculated from several years of data and including all new data as it becomes available)
    Medium (approximately last 6 months)
    Short (approximately last 4 weeks)
  #>
  param (
    # Username of person we want top artists for
    [Parameter(Mandatory)]
    [String]
    $Username,

    # Determines how far back we look
    [Parameter(Mandatory = $false)]
    [String]
    [ValidateSet("long", "medium", "short")]
    $Range
  )

  if ($Range -eq "long") {
    $TimeRange = "long_term"
  } elseif ($Range -eq "medium") {
    $TimeRange = "medium_term"
  } else {
    $TimeRange = "short_term"
  }
  
  Write-Verbose "Attempting to return info on Spotify profile with username of $Username"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/top/artists?time_range=$TimeRange&limit=50&offset=0"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  if ($Response.next) {
    $ResponseArray = @()
    $ResponseArray += $Response
    while ($Response.next) {
      $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -Header $Auth -ErrorAction Stop
      $ResponseArray += $Response
    }
    return $ResponseArray
  }
  return $Response
}