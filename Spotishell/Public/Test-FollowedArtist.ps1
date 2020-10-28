function Test-FollowedArtist {
  <#
  .SYNOPSIS
    Check if current user follows an artist
  .EXAMPLE
    PS C:\> Test-FollowedArtist -Username "xyz" -Id "blahblahblah"
    Check to see if the user authed under the current access token follow the artist with the Id of "blahblahblah"
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the artist we want to check
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # Id of the artist we want to get check
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  Write-Verbose "Checking follow of this artist"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/following/contains?type=artist&ids=$Id"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
}