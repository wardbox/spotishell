function Test-FollowedPlaylist {
  <#
  .SYNOPSIS
    Check if current user follows a playlist
  .EXAMPLE
    PS C:\> Test-FollowedPlaylist -Username "xyz" -Id "blahblahblah"
    Check to see if the user authed under the current access token follow the playlist with the Id of "blahblahblah"
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the playlist we want to check
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # Id of the playlist we want to get check
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  $myId = (Get-MyProfile -Username $Username).id

  Write-Verbose "Checking follow of this playlist"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/playlists/$Id/followers/contains?ids=$myId"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
}