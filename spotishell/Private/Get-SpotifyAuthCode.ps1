function Get-SpotifyAuthCode {
  param (
    # The name of the spotify credentials we've saved
    [Parameter(Mandatory)]
    [string]
    $Name
  )
  
  $Credential = Get-SpotifyCredential -Name $Name
  $ClientId = "client_id=" + $Credential.clientid
  $ResponseType = "response_type=code"
  $RedirectURI = "redirect_uri=http%3A%2F%2Flocalhost%2Fspotifyapi"
  $BaseURI = "https://accounts.spotify.com/authorize?"
  $Guid = [guid]::NewGuid()
  $URI = $BaseURI + $ClientId + "&" + $ResponseType + "&" + $RedirectURI + "&state=" + $Guid

  if ($IsMacOS) {
    # opens the constructed uri in default browser on mac
    open $URI
  } elseif ($IsWindows) {
    
  }
  $Response = Read-Host "paste the entire url that it redirects you to"
  $Response = $Response.Split("spotifyapi?")[1]
  $Code = $Response.Split("&state=")[0]
  $ResponseGuid = $Response.Split("&state=")[1]

  # If our response guid doesn't match the one we made, we don't want to proceed
  if ($ResponseGuid -ne $Guid) {
    Write-Warning "The response guid does not match our records."
    return $Response
  }

  if ($Code -eq "error=access_denied&state=$Guid") {
    Write-Warning "We didn't successfully retrieve an auth code.  This may be due to expired credentials or wardbox messed up."
    return $Code
  }
  $Code = $Code.Replace("code=", "")
  return $Code
}