function Get-CurrentTrack {
  <#
  .SYNOPSIS
    Get information about the user’s current playing track
  .EXAMPLE
    PS C:\> Get-CurrentTrack -Username "billclinton"
    Retrieves the current playing track for user with username "billclinton"
  .PARAMETER Username
    This should be a string.
    The username of the spotify user.  We'll use this to retrieve a saved user access token or get a new one
  #>
  param (
    # Username
    [Parameter(Mandatory)]
    [String]
    $Username
  )
  Write-Verbose "Attempting to return current playing track for user $Username"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/player/currently-playing"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  return $Response
}