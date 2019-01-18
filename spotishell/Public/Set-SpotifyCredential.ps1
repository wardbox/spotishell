function Set-SpotifyCredential {
    <#
  .SYNOPSIS
    Specifies a credential to use
  .DESCRIPTION
    Looks in our spotify credentials folder and sets the "current" credential to use for all calls
  .EXAMPLE
    PS C:\> Set-SpotifyCredential -Name "dev"
    Looks to see if there's a credential named dev.json and sets it to be the current credential if so
  .PARAMETER Name
  This should be a string
  Name of the credential you want to set
  .NOTES
  Doesn't output any object
  #>
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
        $CurrentCredential = Get-Content -Path ($CredentialStorePath + "current.txt") -ErrorAction SilentlyContinue
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