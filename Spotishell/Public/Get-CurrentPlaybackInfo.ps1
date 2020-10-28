function Get-CurrentPlaybackInfo {
  <#
  .SYNOPSIS
    Get information about the user’s current playback state, including track, track progress, and active device.
  .EXAMPLE
    PS C:\> Get-CurrentPlaybackInfo -Username "billclinton"
    retrieves the current playback status for user with username "billclinton"
  .PARAMETER Username
    This should be a string.
    The username of the spotify user.  We'll use this to retrieve a saved user access token or get a new one
  #>
  param(
    # Username
    [String]
    $Username = 'default'
  )
  Write-Verbose "Attempting to return current playback for you"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/player"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  return $Response
}