function Send-SpotifyCall {
    [CmdletBinding()]
    param (

        # Name of spotify credential to use
        [Parameter(Mandatory = $true)]
        [ParameterType]
        $CredentialName,

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

    $AccessToken = Get-SpotifyAccessToken -Name $CredentialName

    if (!($Header)) {
        $Header = @{
            "Authorization" = "Basic " + $AccessToken.access_token
        }
    }

    if (!($Body)) {
        <# The body of this POST request must contain the following parameters encoded
        in application/x-www-form-urlencoded as defined in the OAuth 2.0 specification #>
        $Body = @{
            "grant_type" = "client_credentials"
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
}
