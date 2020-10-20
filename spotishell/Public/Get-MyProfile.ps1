function Get-MyProfile {
  <#
  .SYNOPSIS
    Get info on the current user's profile
  .EXAMPLE
    PS C:\> Get-MyProfile -Username "xyz"
    Gets profile info for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  #>
  param (
    # UserAccessToken
    [String]
    $Username = 'default'
  )
  Write-Verbose "Attempting to return info on your Spotify profile"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  return $Response
}