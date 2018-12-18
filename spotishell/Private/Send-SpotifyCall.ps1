function Send-SpotifyCall {
    [CmdletBinding()]
    param (

        # This is our method
        [Parameter(Mandatory = $true)]
        [string]
        $Method,

        # URI to api endpoint
        [Parameter(Mandatory = $true)]
        [string]
        $Uri,

        # This is the header constructed by previous function.  Typically contains the access token
        [Parameter(Mandatory = $false)]
        [hashtable]
        $Header,

        # Body for call, typically contains sporadic values. Should always be a hash table still.
        [Parameter(Mandatory = $false)]
        [hashtable]
        $Body
    )

    $SpotishellStore = $env:LOCALAPPDATA + "\wardbox\spotishell\"
    $CredentialStorePath = $SpotishellStore + "credential\"
    $CredentialName = Get-Content -Path ($CredentialStorePath + "current.txt")

    if ($CredentialName) {

        $AccessToken = Get-SpotifyAccessToken -Name $CredentialName

        if (!($Header)) {
            $Header = @{
                "Authorization" = "Bearer " + $AccessToken.access_token
            }
        }

        <# Call api for auth token #>
        try {
            Write-Verbose "Attempting to send request to API"
            if ($Body) {
                $Response = Invoke-WebRequest -Method $Method -Headers $Header -Body $Body -Uri $Uri
            } else {
                $Response = Invoke-WebRequest -Method $Method -Headers $Header -Uri $Uri
            }
        } catch {
            Write-Warning "Failed sending request to API"
            break
        }

        if ($Response) {
            Write-Verbose "We got a response!"
            $Response = $Response.Content | ConvertFrom-Json
            return $Response
        } else {
            Write-Warning "No response!"
            break
        }
    } else {
        Write-Warning "No current credential found. Either do New-SpotifyCredential or Set-SpotifyCredential first."
        break
    }
}