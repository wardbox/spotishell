function Get-AvailableDevices {
  <#
  .SYNOPSIS
    List available devices for user
  .EXAMPLE
    PS C:\> Get-AvailableDevices -Username "blahblah"
  #>
  param(
    # Username
    [string]
    $Username = 'default'
  )

  Write-Verbose "Attempting to return available devices for user with username $Username"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/player/devices"
  $UserAccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($UserAccessToken.access_token)"
  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
  return $Response.devices
}