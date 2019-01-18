function Resume-Playback {
  <#
  .SYNOPSIS
    Resume playback on the user's account.
  .EXAMPLE
    PS C:\> Resume-Playback -Username "blahblah"
    Resumes playback for user with username "blahblah"
  .PARAMETER Username
    Username of the spotify user we want to resume playback for
  .PARAMETER DeviceId
    The id of the device this command is targeting.
    If not supplied, the user's currently active device is the target.
  .PARAMETER ContextUri
    This should be a Spotify URI (album(s), artist(s), or playlist(s))
  .PARAMETER TrackUris
    This should be an array of track URIs
  #>
  param (
    # Username
    [Parameter(Mandatory)]
    [string]
    $Username,

    # Device ID that we want to resume playback on
    [Parameter(Mandatory = $false)]
    [array]
    $DeviceId,

    # Spotify URI of the context to play
    [Parameter(Mandatory = $false)]
    [string]
    $ContextUri,

    # An array of the Spotify track URIs to play
    [Parameter(Mandatory = $false)]
    [Array]
    $TrackUris
  )

  Write-Verbose "Attempting to resume playback for user with username $Username"
  $Method = "Put"
  $Uri = "https://api.spotify.com/v1/me/player/play"

  if ($DeviceId) {
    $Uri += "?device_id=$DeviceId"
  }

  if ($ContextUri -or $TrackUris) {
    $Body = @{}
  }

  if ($ContextUri) {
    $Body.context_uri = $ContextUri
  }

  if ($TrackUris) {
    $Body.uris = $TrackUris
  }

  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  if ($Body) {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -Body $Body -ErrorAction Stop
  } else {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  }

  if ($Response.StatusCode -ne "204") {
    return $Response
  }
}