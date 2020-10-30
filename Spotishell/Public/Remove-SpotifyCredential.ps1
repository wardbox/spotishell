function Remove-SpotifyCredential {
  <#
  .SYNOPSIS
    Removes a locally saved spotify credential
  .EXAMPLE
    PS C:\> Remove-SpotifyCredential -Name "dev"
    Looks for a saved credential named "dev" and deletes it from your local machine.
  .PARAMETER Name
    This should be a string
    Name of the credential you want to delete
  #>
  param(
    # Name of our credential
    [Parameter(Mandatory)]
    [string]
    $Name
  )

  if ($IsMacOS -or $IsLinux) {
    $CredentialStorePath = $home + "/.wardbox/spotishell/credential/"
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

  $Credential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

  if ($Credential) {
    $CurrentCredential = Get-Content -Path ($CredentialStorePath + "current.txt")
    if ($CurrentCredential -eq $Name) {
      try {
        Write-Verbose "Current credential is set as $Name, make sure to use Set-SpotifyCredential to create new current credential."
        Remove-Item -Path ($CredentialStorePath + "current.txt") -Force
        Write-Verbose "Deleted file at $($CredentialStorePath + "current.txt")"
      } catch {
        Write-Warning "Unable to delete current.txt with $Name credentials."
        break
      }
    }
    try {
      Write-Verbose "Attempting to delete $Name at $CredentialFilePath"
      Remove-Item -Path $CredentialFilePath
      Write-Verbose "Success"
    } catch {
      Write-Warning "Failed deleting $Name credential"
      break
    }
  } else {
    Write-Warning "There's no existing credential with name $Name"
  }
}