function Test-MultipleFollowedUsers {
  <#
    .SYNOPSIS
      Check if current user follows some Users
    .EXAMPLE
      PS C:\> Test-MultipleFollowedUsers -Username "xyz" -UserArray @("id1","id2")
      Check to see if the user authed under the current access token follow users with Ids "id1" and "id2"
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

  Write-Verbose "Checking follow of those users"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/following/contains?type=user&ids=$($UserArray -join '%2C')"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }
  
  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
}