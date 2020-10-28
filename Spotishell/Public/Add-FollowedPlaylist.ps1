function Add-FollowedPlaylist {
  <#
  .SYNOPSIS
    Follow a new playlist
  .EXAMPLE
    PS C:\> Add-FollowedPlaylist -Username "xyz" -Id "blahblahblah"
    Add the playlist with the Id of "blahblahblah" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the playlist we want to follow
  #>
  param (
    # UserAccessToken
    [Parameter(Mandatory)]
    [String]
    $Username,
    # Id of the playlist we want to follow
    [Parameter(Mandatory)]
    [string]
    $Id,
    # If true the playlist will be included in user’s public playlists, if false it will remain private.
    [bool]
    $public = $true
  )
  Write-Verbose "Attempting to follow this playlist"
  $Method = "Put"
  $Uri = "https://api.spotify.com/v1/playlists/$Id/followers"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{Authorization = "Bearer $($AccessToken.access_token)" }
  $Body = ConvertTo-Json -InputObject @{"public" = $public.ToString() }

  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -Body $Body -ErrorAction Stop | Out-Null
}