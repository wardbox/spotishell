<# Write a function to save spotify secrets in a local location #>
function  New-SpotifyCredential {
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

    $CredentialStore = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

    <# We don't want to destroy any existing credential files, proceeding with caution. #>
    $Overwrite = "n"

    if (!(Test-Path -Path $CredentialStore)) {

        <# 1. There is no credential repo, let's try to make one. #>
        try {
            Write-Verbose "Attempting to create credential store at $CredentialStore"
            New-Item -Path $CredentialStore -ItemType Directory -ErrorAction Stop
            Write-Verbose "Successfully created credential store at $CredentialStore"
        } catch {
            Write-Warning "Failed attempting to create credential store at $CredentialStore"
            Write-Warning "Check error for more details."
            break
        }

    }

    Write-Verbose "Credential store exists at $CredentialStore"

    <# Construct filepath #>
    $CredentialPath = $CredentialStore + $Name + ".json"

    $ExistingCredential = Get-Item -Path $CredentialPath -ErrorAction SilentlyContinue

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
            Write-Verbose "Attempting to save credentials to $CredentialPath"
            $CredentialJSON | Out-File -FilePath $CredentialPath
            Write-Verbose "Successfully saved credentials to $CredentialPath"
        } catch {
            Write-Warning "Failed saving credentials to $CredentialPath"
        }
    } else {
        Write-Verbose "No work to do."
    }
}


<# This is for testing #>
# New-SpotifyCredential -Name "Test2" -ClientId "blahahID" -ClientSecret "blahblahSECRET" -Verbose