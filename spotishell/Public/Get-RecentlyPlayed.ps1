function Get-RecentlyPlayed {
  <#
  .SYNOPSIS
    Get tracks from the current user’s recently played tracks.
  .EXAMPLE
    PS C:\> Get-RecentlyPlayed -Username "billclinton"
    retrieves the recently played tracks for user with username "billclinton"
  .PARAMETER Username
    This should be a string.
    The username of the spotify user.  We'll use this to retrieve a saved user access token or get a new one
  .NOTES
    Returns the most recent 50 tracks played by a user.
    Note that a track currently playing will not be visible in play history until it has completed.
    A track must be played for more than 30 seconds to be included in play history.
  #>
  param(
    [Parameter(Mandatory)]
    [String]
    $Username
  )
  $Limit = "50"
  Write-Verbose "Attempting to return recently played tracks for user $Username"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/player/recently-played?limit=$Limit"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth
  return $Response
}