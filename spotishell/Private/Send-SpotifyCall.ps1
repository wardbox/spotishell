function Send-SpotifyCall {
  <#
  .SYNOPSIS
      Sends a call off to Spotify API
  .DESCRIPTION
      Send a pre-packaged spotify call off to the API.
  .EXAMPLE
      PS C:\> Send-SpotifyCall -Method "get" -Uri "https://my.api.uri.com/blah/v?"
      Uses the default Authorization header and passes Get and the Uri to invoke-webrequest and returns it
  .PARAMETER Method
      Should be a string of "Default", "Delete", "Get", "Head", "Merge", "Options", "Patch", "Post", "Put", or "Trace"
  .PARAMETER Uri
      Should be a string of your URI.  Example: https://api.spotify.com/v1/albums/
  .PARAMETER Header
      Not required.  We will use the default auth header if none specified.
  .PARAMETER Body
      Not required.  Will not use this if not specified.
  #>
  [CmdletBinding()]
  param (

    # This is our method
    [Parameter(Mandatory = $true)]
    [string]
    $Method,

    # URI to api endpoint
    [Parameter(Mandatory = $true)]
    [string]
    $Uri,

    # This is the header constructed by previous function.  Typically contains the access token
    [Parameter(Mandatory = $false)]
    [hashtable]
    $Header,

    # Body for call, typically contains sporadic values. Should always be a hash table still.
    [Parameter(Mandatory = $false)]
    [hashtable]
    $Body
  )

  if ($IsMacOS -or $IsLinux) {
    $SpotishellStore = $home + "/.wardbox/spotishell/"
  } else {
    $SpotishellStore = $env:LOCALAPPDATA + "\wardbox\spotishell\"
  }

  $CredentialStorePath = $SpotishellStore + "credential\"
  $CredentialName = Get-Content -Path ($CredentialStorePath + "current.txt")

  if ($CredentialName) {

    $AccessToken = Get-SpotifyAccessToken -Name $CredentialName

    if (!($Header)) {
      $Header = @{
        "Authorization" = "Bearer " + $AccessToken.access_token
      }
    }

    <# Call api for auth token #>
    Write-Verbose "Attempting to send request to API"
    if ($Body) {
      $Response = Invoke-WebRequest -Method $Method -Headers $Header -Body $Body -Uri $Uri
    } else {
      $Response = Invoke-WebRequest -Method $Method -Headers $Header -Uri $Uri
    }

    if ($Response) {
      Write-Verbose "We got a response!"
      if ($Response.StatusCode -eq "200") {
        $Response = $Response.Content | ConvertFrom-Json
      }
      return $Response
    } else {
      Write-Warning "No response!"
      break
    }
  } else {
    Write-Warning "No current credential found. Either do New-SpotifyCredential or Set-SpotifyCredential first."
    break
  }
}