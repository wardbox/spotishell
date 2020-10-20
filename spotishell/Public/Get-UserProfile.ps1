function Get-UserProfile {
  <#
  .SYNOPSIS
    Get public profile information about a Spotify user.
  .EXAMPLE
    PS C:\> Get-UserProfile -Username "myusername"
   Gets the public user profile information about myusername
  .PARAMETER Username
    This should be a string.
    Username of the spotify user we want to search for
  #>
  param (
    # Username
    [String]
    $Username = 'default'
  )
  
  Write-Verbose "Attempting to return profile of user with ID $Username"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/users/" + $Username

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}