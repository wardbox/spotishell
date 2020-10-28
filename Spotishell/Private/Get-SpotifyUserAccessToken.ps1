function Get-SpotifyUserAccessToken {
  <#
  .SYNOPSIS
    Gets a spotify user access token
  .DESCRIPTION
    Gets a spotify user access token by talking to the API and sending clientId and clientSecret
  .EXAMPLE
    PS C:\> Get-SpotifyUserAccessToken -Name "dev"
    Looks for a saved credential named "dev" and tries to get an access token with it's credentials
  .PARAMETER Name
    Is a string, should be the name of your credential
  .OUTPUTS
    This will output the credential object
  #>
  [CmdletBinding()]
  param (
    # Spotify username
    [String]
    $Username = 'default'
  )

  if ($IsMacOS -or $IsLinux) {
    $SpotishellStore = $home + "/.wardbox/spotishell/"
    $UserAccessTokenStorePath = $SpotishellStore + "user_access_tokens/"
  } else {
    $SpotishellStore = $env:LOCALAPPDATA + "\wardbox\spotishell\"
    $UserAccessTokenStorePath = $SpotishellStore + "user_access_tokens\"
  }

  $UserAccessTokenFilePath = $UserAccessTokenStorePath + "$Username.json"

  <# Check if we have a valid access token already #>
  if (!(Test-Path -Path $UserAccessTokenStorePath)) {
    <# There is no access token store, let's try to make one. #>
    try {
      Write-Verbose "Attempting to create access token store at $UserAccessTokenStorePath"
      New-Item -Path $UserAccessTokenStorePath -ItemType Directory -ErrorAction Stop
      Write-Verbose "Successfully created access token store at $UserAccessTokenStorePath"
    } catch {
      Write-Warning "Failed attempting to create access token store at $UserAccessTokenStorePath"
      Write-Warning "Check error for more details."
      break
    }
  }

  Write-Verbose "Access token store exists at $UserAccessTokenStorePath"

  if ($UserAccessTokenFilePath) {
    try {
      Write-Verbose "Attempting to read access token from $UserAccessTokenFilePath"
      $ExistingAccessToken = Get-Content -Path $UserAccessTokenFilePath -ErrorAction SilentlyContinue | ConvertFrom-Json -ErrorAction Stop
    } catch {
      Write-Warning "Couldn't convert existing access token from JSON"
      break
    }
  }

  if ($ExistingAccessToken) {
    $Expires = [DateTime]::ParseExact($ExistingAccessToken.expires_in,'u',$null)
    $CurrentTime = Get-Date
    if ($CurrentTime -le $Expires.AddSeconds(-10)) {
      return $ExistingAccessToken
    }
  }

  try {
    $SpotifyCredentials = Get-SpotifyCredential
  } catch {
    Write-Warning "Couldn't find spotify credentials.  Try New-SpotifyCredentials."
    break
  }

  if ($SpotifyCredentials.ClientId -and $SpotifyCredentials.ClientSecret) {
    $Uri = "https://accounts.spotify.com/api/token"
    $Method = "Post"

    if (!$ExistingAccessToken.refresh_token) {
      $AuthCode = Get-SpotifyAuthCode
      $Body = @{
        "grant_type"   = "authorization_code"
        "code"         = $AuthCode
        "redirect_uri" = "http://localhost:8080/spotifyapi"
      }
    } else {
      $Body = @{
        "grant_type"    = "refresh_token"
        "refresh_token" = $ExistingAccessToken.refresh_token
      }
    }
  } else {
    $SpotifyCredentials = New-SpotifyCredential -Name $Name -ClientId (Read-Host -Prompt "ClientId") -ClientSecret (Read-Host "ClientSecret")
  }

  <# Base 64 encoded string that contains the client ID and client secret key. #>
  $CombinedCredentials = [System.Text.Encoding]::UTF8.GetBytes($SpotifyCredentials.ClientId + ":" + $SpotifyCredentials.ClientSecret)
  $Base64Credentials = [System.Convert]::ToBase64String($CombinedCredentials)
  $Auth = @{
    "Authorization" = "Basic " + $Base64Credentials
  }

  <# Call api for auth token #>
  try {
    Write-Verbose "Attempting to send request to API to get access token."
    $Response = Invoke-WebRequest -Uri $Uri -Method $Method -Body $Body -Headers $Auth
    $CurrentTime = Get-Date
  } catch {
    Write-Warning "Failed sending request to API to get access token."
    break
  }

  if ($Response) {
    Write-Verbose "We got a response!"
    if ($Response.StatusCode -eq "200") {
      $Response = $Response.Content | ConvertFrom-Json
      try {
        $Expires = $CurrentTime.AddSeconds($Response."expires_in")
        $UserAccessTokenJSON = @{
          access_token  = $Response."access_token"
          token_type    = $Response."token_type"
          scope         = $Response."scope"
          expires_in    = $Expires.ToString('u')
          refresh_token = $Response."refresh_token"
        }
        $UserAccessTokenJSON | ConvertTo-Json -Depth 100 | Out-File -FilePath $UserAccessTokenFilePath
        Write-Verbose "Successfully saved access token to $UserAccessTokenFilePath"
        $UserAccessTokenObject = Get-Content $UserAccessTokenFilePath | ConvertFrom-Json -ErrorAction Stop
        return $UserAccessTokenObject
      } catch {
        Write-Warning "Failed saving access token to $UserAccessTokenFilePath"
      }
    } else {
      Write-Warning "We got a bad response."
      Write-Warning "$($Response.StatusCode)"
      Write-Warning "$($Response.StatusDescription)"
      break
    }
  } else {
    Write-Warning "No response!"
    break
  }
}