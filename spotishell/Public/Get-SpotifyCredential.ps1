function  Get-SpotifyCredential {
    param (
        <# Credential name so user can identify it #>
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )

    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

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
        Write-Warning "No crednetial found with name $Name"
        return "No credential found with name $Name"
    }
}