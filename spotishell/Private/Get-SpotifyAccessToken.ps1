function Get-SpotifyAccessToken {
    [CmdletBinding()]
    param (
        <# This is the name of the credential you want to use #>
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )

    $SpotishellStore = $env:LOCALAPPDATA + "\wardbox\spotishell\"
    $AccessTokenStorePath = $SpotishellStore + "access_token\"
    $CredentialStorePath = $SpotishellStore + "credential\"
    $AccessTokenFilePath = $AccessTokenStorePath + $Name + ".json"
    $CredentialFilePath = $CredentialStorePath + $Name + ".json"

    <# Check if we have a valid access token already #>
    if (!(Test-Path -Path $AccessTokenStorePath)) {
        <# There is no access token store, let's try to make one. #>
        try {
            Write-Verbose "Attempting to create access token store at $AccessTokenStorePath"
            New-Item -Path $AccessTokenStorePath -ItemType Directory -ErrorAction Stop
            Write-Verbose "Successfully created access token store at $AccessTokenStorePath"
        } catch {
            Write-Warning "Failed attempting to create access token store at $AccessTokenStorePath"
            Write-Warning "Check error for more details."
            break
        }
    }

    Write-Verbose "Access token store exists at $AccessTokenStorePath"

    try {
        Write-Verbose "Attempting to read access token from $AccessTokenFilePath"
        $ExistingAccessToken = Get-Content -Path $AccessTokenFilePath -ErrorAction SilentlyContinue | ConvertFrom-Json -ErrorAction Stop
    } catch {
        Write-Warning "Couldn't convert existing access token from JSON"
        break
    }

    if ($ExistingAccessToken) {
        $Expires = $ExistingAccessToken.expires | Get-Date
        $CurrentTime = Get-Date
        if ($CurrentTime -le $Expires.AddSeconds(-10)) {
            return $ExistingAccessToken
        }
    }

    <# The request is sent to the /api/token endpoint of the Accounts service:
        POST https://accounts.spotify.com/api/token #>
    $Uri = "https://accounts.spotify.com/api/token"
    $Method = "Post"

    <# The body of this POST request must contain the following parameters encoded
        in application/x-www-form-urlencoded as defined in the OAuth 2.0 specification #>
    $Body = @{
        "grant_type" = "client_credentials"
    }

    <# Call api for auth token #>
    try {
        Write-Verbose "Attempting to send request to API"
        Send-SpotifyCall -CredentialName $Name -Uri $Uri -Method $Method -Body $Body
        $CurrentTime = Get-Date
    } catch {
        Write-Warning "Failed sending request to API"
        break
    }

    if ($Response) {
        Write-Verbose "We got a response!"
        if ($Response.StatusCode -eq "200") {
            $Response = $Response.Content | ConvertFrom-Json
            try {
                $Expires = $CurrentTime.AddSeconds($Response."expires_in")
                $AccessTokenJSON = @{
                    access_token = $Response."access_token";
                    token_type   = $Response."token_type";
                    expires      = "$Expires";
                    scope        = $Response."scope";
                }
                $AccessTokenJSON | ConvertTo-Json -Depth 100 | Out-File -FilePath $AccessTokenFilePath
                Write-Verbose "Successfully saved access token to $AccessTokenFilePath"
                return $Response.Content."access_token"
            } catch {
                Write-Warning "Failed saving access token to $AccessTokenFilePath"
            }
        } else {
            Write-Warning "We got a bad response."
            Write-Warning "$($Response.StatusCode)"
            Write-Warning "$($Response.StatusDescription)"
            break
        }
    } else {
        Write-Warning "No response!"
        break
    }
}

<# This is for testing #>
#Get-SpotifyAccessToken -Name "dev" -Verbose