function Get-UserTopTracks {
  <#
  .SYNOPSIS
    Get top tracks for user
  .EXAMPLE
    PS C:\> Get-UserTopTracks -Range "long"
    Gets top tracks for user over several years
  .PARAMETER Range
  Long (calculated from several years of data and including all new data as it becomes available)
  Medium (approximately last 6 months)
  Short (approximately last 4 weeks)
  #>
  param (
    # Username of person we want top tracks for
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
  $Uri = "https://api.spotify.com/v1/me/top/tracks?time_range=$TimeRange&limit=50&offset=0"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
    if ($Response.next) {
      $ResponseArray = @()
      $ResponseArray += $Response
      while ($Response.next) {
        $ResponseArray += Send-SpotifyCall -Method $Method -Uri $Response.next -Header $Auth -ErrorAction Stop
      }
      return $ResponseArray
    }
    return $Response
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-MyProfile"
  }
}