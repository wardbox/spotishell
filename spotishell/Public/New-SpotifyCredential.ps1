function  New-SpotifyCredential {
  <#
  .SYNOPSIS
    Creates a new credential file
  .DESCRIPTION
    Creates a new credential file and saves it locally so you may re-use it without setting it every time
  .EXAMPLE
    PS C:\> New-SpotifyCredential -Name "dev" -ClientId "blahblahID" -ClientSecret "blahblahSecret"
    Creates a new credential json with name dev.json and supplied ClientId and ClientSecret.  Also asks if you want to set current.json to this if it exists,
    otherwise just sets current.json to this credential.
  .PARAMETER Name
    This should be a string.
    It is the name of the credential you want to save.  Personally, I recommend setting this to your registered project name
  .PARAMETER ClientId
    This should be a string
    Obtained here: https://developer.spotify.com/dashboard/
  .PARAMETER ClientSecret
    This should be a string
    Obtained here: https://developer.spotify.com/dashboard/
  #>
  param (
    <# Credential name so user can identify it #>
    # Parameter help description
    [Parameter(Mandatory = $true)]
    [String]
    $Name,

    <# Client ID, obtained from one of your applications on the Spotify developer dashboard:
    https://developer.spotify.com/dashboard/applications (as of this writing) #>
    [Parameter(Mandatory = $true)]
    [String]
    $ClientId,

    <# Client Secret, obtained from one of your applications on the Spotify developer dashboard:
    https://developer.spotify.com/dashboard/applications (as of this writing) #>
    [Parameter(Mandatory = $true)]
    [String]
    $ClientSecret
  )

  if ($IsMacOS -or $IsLinux) {
    $CredentialStorePath = $home + "/" + "/.wardbox/spotishell/credential/"
  } else {
    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"
  }

  <# We don't want to destroy any existing credential files, proceeding with caution. #>
  $Overwrite = "n"

  if (!(Test-Path -Path $CredentialStorePath)) {

    <# There is no credential repo, let's try to make one. #>
    try {
      Write-Verbose "Attempting to create credential store at $CredentialStorePath"
      New-Item -Path $CredentialStorePath -ItemType Directory -ErrorAction Stop
      Write-Verbose "Successfully created credential store at $CredentialStorePath"
    } catch {
      Write-Warning "Failed attempting to create credential store at $CredentialStorePath"
      Write-Warning "Check error for more details."
      break
    }

  }

  Write-Verbose "Credential store exists at $CredentialStorePath"

  <# Construct filepath #>
  $CredentialFilePath = $CredentialStorePath + $Name + ".json"

  $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

  if ($ExistingCredential) {
    $Overwrite = Read-Host -Prompt "Found existing credential with name $Name, do you want to overwrite it? (y/n)"
  } else {
    $OverWrite = "y"
  }

  <# Assemble credential JSON #>
  $CredentialJSON = @{
    ClientId     = $ClientId;
    ClientSecret = $ClientSecret
  }

  <# Converts our hash table to JSON so we can save it locally. #>
  $CredentialJSON = $CredentialJSON | ConvertTo-Json -Depth 100

  if ($Overwrite -like "y*") {
    <# Try to save credential to file. #>
    try {
      Write-Verbose "Attempting to save credentials to $CredentialFilePath"
      $CredentialJSON | Out-File -FilePath $CredentialFilePath
      Write-Verbose "Successfully saved credentials to $CredentialFilePath"
      if (Get-Item -Path ($CredentialStorePath + "current.txt")) {
        $CurrentOverwrite = Read-Host "There's a current.txt with a different credential, want to overwrite it with $Name?(y/n)"
        if ($CurrentOverwrite -like "y*") {
          Set-SpotifyCredential -Name $Name
        }
      } else {
        Set-SpotifyCredential -Name $Name
      }
      $CredentialObject = Get-Content $CredentialFilePath | ConvertFrom-Json -ErrorAction Stop
      return $CredentialObject
    } catch {
      Write-Warning "Failed saving credentials to $CredentialFilePath"
    }
  } else {
    Write-Verbose "No work to do."
  }
}