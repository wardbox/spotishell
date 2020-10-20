function Add-MultipleFollowedUsers {
  <#
  .SYNOPSIS
    Follow multiple new users
  .EXAMPLE
    PS C:\> Add-MultipleFollowedUsers -Username "xyz" -UserArray @("id1","id2")
    Add users with Ids "id1" and "id2" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER UserArray
    An array of no greater than 50 user Ids
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # The array of user Ids
    [Parameter(Mandatory)]
    [array]
    $UserArray
  )

  if ($UserArray.Count -gt 50) {
    Write-Warning "Can't follow more than 50 at a time."
    break
  }

  Write-Verbose "Attempting to follow those users"
  $Method = "Put"
  $Uri = "https://api.spotify.com/v1/me/following?type=user&ids=$($UserArray -join '%2C')"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}