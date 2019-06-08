function Set-PCPlaybackVolume {
    <#
    .SYNOPSIS
      Set volume (1-100) for current playback..
    .EXAMPLE
      PS C:\> Set-PCPlaybackVolume -Username "blahblah" -Volume 69
      Sets playback volume to 69. (1-100) (Only works on computers, not mobile devices.)
    .PARAMETER Username
      Username of the spotify user we want change the volume for
    .PARAMETER Username
      Volume (1-100) that you want to set for current playback
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

      # Volume
      [Parameter(Mandatory)]
      [int]
      $Volume,
  
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
  
    Write-Verbose "Attempting to skip to next song for user with username $Username"
    $Method = "Put"
    $Uri = "https://api.spotify.com/v1/me/player/volume"
  
    if ($DeviceId) {
      $Uri += "?device_id=$DeviceId"
    }
  if ($Volume) {
    $Uri += "?volume_percent=$volume"
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
