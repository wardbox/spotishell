function Remove-FollowedPlaylist {
  <#
  .SYNOPSIS
    Unfollow a new Playlist
  .EXAMPLE
    PS C:\> Remove-FollowedPlaylist -Username "xyz" -Id "blahblahblah"
    Remove the playlist with the Id of "blahblahblah" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the playlist we want to unfollow
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # Id of the playlist we want to follow
    [Parameter(Mandatory)]
    [string]
    $Id
  )
  Write-Verbose 'Attempting to unfollow this playlist'
  $Method = 'Delete'
  $Uri = "https://api.spotify.com/v1/playlists/$Id/followers"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}