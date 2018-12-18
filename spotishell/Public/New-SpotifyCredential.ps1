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

    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

    <# We don't want to destroy any existing credential files, proceeding with caution. #>
    $Overwrite = "n"

    if (!(Test-Path -Path $CredentialStorePath)) {

        <# 1. There is no credential repo, let's try to make one. #>
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