function Get-SpotifyAuthCode {
  param (
    # The name of the spotify credentials we've saved
    [string]
    $Name
  )

  if ($Name) {
    $Credential = Get-SpotifyCredential -Name $Name
  } else {
    $Credential = Get-SpotifyCredential
  }
  $ClientId = "client_id=" + $Credential.clientid
  $ResponseType = "response_type=code"
  $RedirectURI = "redirect_uri=http%3A%2F%2Flocalhost%2Fspotifyapi"
  $Scopes = @(
    "playlist-read-private",
    "playlist-modify-private",
    "playlist-modify-public",
    "playlist-read-collaborative",
    "user-modify-playback-state",
    "user-read-currently-playing",
    "user-read-playback-state",
    <#commenting out user-top-read as it makes the module fail, works without this on win10 pwsh 7 #>
    <#"user-top-read",#>
    "user-read-recently-played",
    "app-remote-control",
    "streaming",
    "user-read-email",
    "user-read-private",
    "user-follow-read",
    "user-follow-modify",
    "user-library-modify",
    "user-library-read"
  )
  $UriScopes = "scope="
  $Count = $Scopes.Count
  foreach ($Scope in $Scopes) {
    if ($Count -gt 1) {
      $UriScopes += "$Scope%20"
    } else {
      $UriScopes += "$Scope"
    }
    $Count--
  }
  $BaseURI = "https://accounts.spotify.com/authorize?"
  $Guid = [guid]::NewGuid()
  Write-Verbose "Using GUID $Guid"
  $URI = $BaseURI + $ClientId + "&" + $ResponseType + "&" + $RedirectURI + "&" + $UriScopes + "&state=$Guid"
  Write-Verbose "Using URI $URI"

  if ($IsMacOS) {
    # opens the constructed uri in default browser on mac
    Write-Verbose "We are on Mac OS"
    open $URI
  }
  elseif ($IsLinux) {
    throw 'Authorization Code Flow is not supported on Linux'
  }
  else { #so we are on Windows
    Write-Verbose "We are on Windows"
    rundll32 url.dll,FileProtocolHandler $URI
  }

  $Response = Read-Host "Paste the entire URL that it redirects you to"
  $Response = ($Response -Split 'spotifyapi?')[1]
  $SplitResponse = $Response -Split '&state='
  $Code = $SplitResponse[0]
  $ResponseGuid = $SplitResponse[1]

  # If our response guid doesn't match the one we made, we don't want to proceed
  if ($ResponseGuid -ne $Guid) {
    Write-Warning "The response guid does not match our records."
    return $Response
  }

  if ($Code -eq "error=access_denied&state=$Guid") {
    Write-Warning "We didn't successfully retrieve an auth code.  This may be due to expired credentials or wardbox messed up."
    return $Code
  }
  $Code = $Code.Replace("?code=", "")
  return $Code
}
