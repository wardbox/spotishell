function Get-SpotifyAuthCode {
  param (
    # The name of the spotify credentials we've saved
    [Parameter(Mandatory)]
    [string]
    $Name
  )
  
  $Method = "Get"
  $Credential = Get-SpotifyCredential -Name $Name
  $ClientId = "client_id=" + $Credential.clientid
  $ResponseType = "response_type=code"
  $RedirectURI = "redirect_uri=http%3A%2F%2Flocalhost%2Fspotifyapi"
  $BaseURI = "https://accounts.spotify.com/authorize?"
  $Guid = "state=" + [guid]::NewGuid()
  $URI = $BaseURI + $ClientId + "&" + $ResponseType + "&" + $RedirectURI + "&" + $Guid

  if ($IsMacOS) {
    # opens the constructed uri in default browser on mac
    open $URI
  } elseif ($IsWindows) {
    
  }
  $Response = Read-Host "paste the entire url that it redirects you to"
  $CodeWithGuid = $Response.split("?")[1]
  $Code = $CodeWithGuid.split("&")[0]
  $ResponseGuid = $CodeWithGuid.split("&")[1]
  if($ResponseGuid -eq $Guid){
    $AuthCode = $Code
  } else {
    Write-Warning "Doesn't contain secure guid."
    break
  }
  return $AuthCode
}