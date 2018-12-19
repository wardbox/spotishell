function Set-SpotifyCredential {
  param(
    # Name of our credential we've created
    [Parameter(Mandatory = $true)]
    [string]
    $Name
  )

  if ($IsMacOS -or $IsLinux) {
    $CredentialStorePath = $home + "/" + "/.wardbox/spotishell/credential/"
  } else {
    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"
  }
  
  # If we don't have a credential store, tell user to make one
  if (!(Test-Path -Path $CredentialStorePath)) {
    Write-Warning "Failed attempting to create credential store at $CredentialStorePath"
    Write-Warning "Suggest running New-SpotifyCredential to create a credential first."
    break
  }

  Write-Verbose "Credential store exists at $CredentialStorePath"

  <# Construct filepath #>
  $CredentialFilePath = $CredentialStorePath + $Name + ".json"

  $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

  if ($ExistingCredential) {
    $CurrentCredential = Get-Content -Path ($CredentialStorePath + "current.txt")
    if ($CurrentCredential -ne $Name) {
      try {
        Write-Verbose "Attempting to save current.txt with $Name credentials"
        "$Name" | New-Item -Path ($CredentialStorePath + "current.txt") -Force
        Write-Verbose "Success"
      } catch {
        Write-Warning "Unable to create current.txt with $Name credentials."
        break
      }
    } else {
      Write-Verbose "$Name is already set as the current credential."
    }
  } else {
    Write-Warning "There's no existing credential with name $Name"
  }
}