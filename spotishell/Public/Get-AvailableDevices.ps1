function Get-AvailableDevices {
  param(
    # Username
    [Parameter(Mandatory)]
    [string]
    $Username
  )

  Write-Verbose "Attempting to return available devices for user with username $Username"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/player/devices"
  $UserAccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($UserAccessToken.access_token)"
  }

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
    return $Response.devices
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-AvailableDevices"
  }
}