function Remove-FollowedUser {
  <#
  .SYNOPSIS
    Unfollow a new User
  .EXAMPLE
    PS C:\> Remove-FollowedUser -Username "xyz" -Id "blahblahblah"
    Remove the user with the Id of "blahblahblah" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the user we want to unfollow
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
  Write-Verbose 'Attempting to unfollow this user'
  $Method = 'Delete'
  $Uri = "https://api.spotify.com/v1/me/following?type=user&ids=$Id"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}