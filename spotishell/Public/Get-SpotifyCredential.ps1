function  Get-SpotifyCredential {
  <#
  .SYNOPSIS
    Retrieves saved spotify credential
  .DESCRIPTION
    Finds saved spotify credential on local machine if there is one.
  .EXAMPLE
    PS C:\> Get-SpotifyCredential -Name "dev"
    Looks for a saved spotify credential file of the name "dev"
  .PARAMETER Name
    Should be a string.
    This is the name of the spotify credential you've created already.
  #>
  param (
    <# Credential name so user can identify it #>
    # Parameter help description
    [Parameter(Mandatory = $true)]
    [String]
    $Name
  )

  if ($IsMacOS -or $IsLinux) {
    $CredentialStorePath = $home + "/" + "/.wardbox/spotishell/credential/"
  } else {
    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"
  }

  if (!(Test-Path -Path $CredentialStorePath)) {
    Write-Warning "No path at $CredentialStorePath, you need to make a credential first"
  }

  Write-Verbose "Credential store exists at $CredentialStorePath"

  <# Construct filepath #>
  $CredentialFilePath = $CredentialStorePath + $Name + ".json"

  $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

  if ($ExistingCredential) {
    $Credential = Get-Content $ExistingCredential | ConvertFrom-Json -ErrorAction Stop
    return $Credential
  } else {
    Write-Warning "No credential found with name $Name"
    return "No credential found with name $Name"
  }
}