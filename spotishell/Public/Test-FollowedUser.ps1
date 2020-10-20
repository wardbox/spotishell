function Test-FollowedUser {
  <#
  .SYNOPSIS
    Check if current user follows a user
  .EXAMPLE
    PS C:\> Test-FollowedUser -Username "xyz" -Id "blahblahblah"
    Check to see if the user authed under the current access token follow the user with the Id of "blahblahblah"
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the user we want to check
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # Id of the user we want to get check
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  Write-Verbose "Checking follow of this user"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/following/contains?type=user&ids=$Id"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
}