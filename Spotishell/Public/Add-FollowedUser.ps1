function Add-FollowedUser {
  <#
  .SYNOPSIS
    Follow a new User
  .EXAMPLE
    PS C:\> Add-FollowedUser -Username "xyz" -Id "blahblahblah"
    Add the user with the Id of "blahblahblah" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the user we want to follow
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # Id of the user we want to follow
    [Parameter(Mandatory)]
    [string]
    $Id
  )
  Write-Verbose "Attempting to follow this user"
  $Method = "Put"
  $Uri = "https://api.spotify.com/v1/me/following?type=user&ids=$Id"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}