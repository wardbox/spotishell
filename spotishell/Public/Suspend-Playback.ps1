function Suspend-Playback {
  <#
  .SYNOPSIS
    Pause playback on the user’s account.
  .EXAMPLE
    PS C:\> Suspend-Playback -Username "blahblah"
    Pauses playback for user with username "blahblah"
  .PARAMETER Username
    Username of the spotify user we want to pause playback for
  .PARAMETER DeviceId
    The id of the device this command is targeting.
    If not supplied, the user’s currently active device is the target.
  #>
  param (
    # Username
    [Parameter(Mandatory)]
    [string]
    $Username,

    # Device ID that we want to pause playback on
    [Parameter(Mandatory = $false)]
    [array]
    $DeviceId
  )

  Write-Verbose "Attempting to pause playback for user with username $Username"
  $Method = "Put"
  $Uri = "https://api.spotify.com/v1/me/player/pause"
  if ($DeviceId) {
    $Uri = "?device_id=$DeviceId"
  }
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  if ($Response.StatusCode -ne "204") {
    return $Response
  }
}