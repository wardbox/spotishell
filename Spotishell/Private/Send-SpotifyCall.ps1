<#
    .SYNOPSIS
        Sends a call off to Spotify API
    .DESCRIPTION
        Send a pre-packaged spotify call off to the API.
    .EXAMPLE
        PS C:\> Send-SpotifyCall -Method 'Get' -Uri 'https://api.spotify.com/v1/me'
        Uses the default Authorization header and passes Get and the Uri to invoke-webrequest and returns it
    .PARAMETER Method
        Specifies the HTTP request method (usually Get, Put, Post, Delete)        
    .PARAMETER Uri
        Specifies the URI of the internet ressource. Example: https://api.spotify.com/v1/albums/
    .PARAMETER Body
        Specifies the Body of the request to send
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Send-SpotifyCall {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Method,

        [Parameter(Mandatory)]
        [string]
        $Uri,

        $Body,

        [string]
        $ApplicationName
    )

    # Prepare header
    $Header = @{
        Authorization = 'Bearer ' + (Get-SpotifyAccessToken -ApplicationName $ApplicationName)
    }

    Write-Verbose 'Attempting to send request to API'

    $ProgressPreference = 'SilentlyContinue'
    try {
        $Response = Invoke-WebRequest -Method $Method -Headers $Header -Body $Body -Uri $Uri
    }
    catch {
        # if we hit the rate limit of Spotify API, code is 429
        if ($_.Exception.Response.StatusCode -eq 429) {
            $WaitTime = ([int]$_.Exception.Response.Headers['retry-after']) + 1
            Write-Warning "API Rate Limit reached, Spotify asked to wait $WaitTime seconds"

            # wait number of seconds indicated by Spotify
            Start-Sleep -Seconds $WaitTime 

            # then make request again (no try catch this time)
            $Response = Invoke-WebRequest -Method $Method -Headers $Header -Body $Body -Uri $Uri
        }
        else {
            # Exception is not Rate Limit so throw it
            Throw $PSItem
        }
    }
    $ProgressPreference = 'Continue'

    Write-Verbose 'We got API response'
    return $Response.Content | ConvertFrom-Json
}