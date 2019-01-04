function Get-MyProfile {
  <#
  .SYNOPSIS
    Get info on the current user's profile
  .EXAMPLE
    PS C:\> Get-MyProfile -AccessToken "xyz"
    Gets profile info for the user authed under the current access token
  .PARAMETER AccessToken
  This should be a string.
  You get this from running Get-SpotifyUserAccessToken
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $AccessToken
  )
  Write-Verbose "Attempting to return info on your Spotify profile"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me"
  $Auth = @{
    Authorization = "Bearer $AccessToken"
  }

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
    return $Response
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-MyProfile"
  }
}