function  New-SpotifyCredential {
    <#
  .SYNOPSIS
    Creates a new credential file
  .DESCRIPTION
    Creates a new credential file and saves it locally so you may re-use it without setting it every time
  .EXAMPLE
    PS C:\> New-SpotifyCredential -Name "dev"
    Creates a new credential json with name dev.json.  Also asks if you want to set current.json to this if it exists,
    otherwise just sets current.json to this credential.
  .PARAMETER Name
    This should be a string.
    It is the name of the credential you want to save.  Personally, I recommend setting this to your registered project name
  #>
    param (
        <# Credential name so user can identify it #>
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )


    if ($IsMacOS -or $IsLinux) {
        $CredentialStorePath = Join-Path -Path $Home -ChildPath "/.wardbox/spotishell/credential/"
    } else {
        $CredentialStorePath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "\wardbox\spotishell\credential\"
    }

    <# We don't want to destroy any existing credential files, proceeding with caution. #>
    $Overwrite = $False

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

    $CredentialFilePath = Join-Path -Path $CredentialStorePath -ChildPath "$Name.json"

    $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

    if ($ExistingCredential) {
        $Overwrite = Read-Host -Prompt "Found existing credential with name $Name, do you want to overwrite it? (y/n)"
    } else {
        $OverWrite = $True
    }

    if ($env:SPOTIFY_CLIENT_ID -and $env:SPOTIFY_CLIENT_SECRET) {
        $CredentialJSON = @{
            ClientId     = $env:SPOTIFY_CLIENT_ID;
            ClientSecret = $env:SPOTIFY_CLIENT_SECRET
        }
    } else {
        Write-Warning "Expected SPOTIFY_CLIENT_ID and SPOTIFY_CLIENT_SECRET environment variables."
    }


    if ($CredentialJSON) {
        <# Converts our hash table to JSON so we can save it locally. #>
        $CredentialJSON = $CredentialJSON | ConvertTo-Json -Depth 100

        if ($Overwrite -or $Overwrite -like "y*") {
            <# Try to save credential to file. #>
            try {
                Write-Verbose "Attempting to save credentials to $CredentialFilePath"
                $CredentialJSON | Out-File -FilePath $CredentialFilePath
                Write-Verbose "Successfully saved credentials to $CredentialFilePath"
                if (Get-Item -Path ($CredentialStorePath + "current.txt") -ErrorAction SilentlyContinue) {
                    $CurrentOverwrite = Read-Host "There's a current.txt with a different credential, want to overwrite it with $Name?(y/n)"
                    if ($CurrentOverwrite -like "y*") {
                        Set-SpotifyCredential -Name $Name
                    }
                } else {
                    Set-SpotifyCredential -Name $Name
                }
            } catch {
                Write-Warning "Failed saving credentials to $CredentialFilePath"
            }
        } else {
            Write-Verbose "No work to do."
        }
    } else {
        Write-Warning "No credential supplied, check environment variables."
    }
}