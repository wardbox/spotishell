<#
    .SYNOPSIS
        Gets a Spotify access token
    .DESCRIPTION
        Gets a Spotify access token using defined SpotifyApplication
        It follows the Authorization Code Flow (https://developer.spotify.com/documentation/general/guides/authorization-guide/#authorization-code-flow)
    .EXAMPLE
        PS C:\> Get-SpotifyAccessToken -ApplicationName 'dev'
        Looks for a saved credential named "dev" and tries to get an access token with it's credentials
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-SpotifyAccessToken {

    [CmdletBinding()]
    param (
        [String]
        $ApplicationName
    )

    # Get Application from the Store
    $Application = Get-SpotifyApplication -Name $ApplicationName

    # If Token is available
    if ($Application.Token) {

        # Check that Access Token is not expired
        $Expires = [DateTime]::ParseExact($Application.Token.Expires, 'u', $null)
        if ((Get-Date) -le $Expires.AddSeconds(-10)) {
            # Access Token is still valid, then use it
            return $Application.Token.access_token
        }
        else {
            # Access Token is expired, need to be refreshed
            
            # ------------------------------ Token Refreshed retrieval ------------------------------
            # STEP 1 : Prepare
            $Uri = 'https://accounts.spotify.com/api/token'
            $Method = 'Post'
            $Body = @{
                grant_type    = 'refresh_token'
                refresh_token = $Application.Token.refresh_token
                client_id     = $Application.ClientId # alternative way to send the client id and secret
                client_secret = $Application.ClientSecret # alternative way to send the client id and secret
            }

            # STEP 2 : Make request to the Spotify Accounts service
            try {
                Write-Verbose 'Send request to refresh access token.'
                $CurrentTime = Get-Date
                $Response = Invoke-WebRequest -Uri $Uri -Method $Method -Body $Body
            }
            catch {
                Throw "Error occured during request of refreshed access token : $($PSItem[0].ToString())"
            }

            # STEP 3 : Parse and save response
            $ResponseContent = $Response.Content | ConvertFrom-Json

            $Token = @{
                access_token  = $ResponseContent.access_token
                token_type    = $ResponseContent.token_type
                scope         = $ResponseContent.scope
                expires       = $CurrentTime.AddSeconds($ResponseContent.expires_in).ToString('u')
                refresh_token = if ($ResponseContent.refresh_token) { $ResponseContent.refresh_token } else { $Application.Token.refresh_token }
            }

            Set-SpotifyApplication -Name $ApplicationName -Token $Token
            Write-Verbose 'Successfully saved Refreshed Token'

            return $Token.access_token

        }
    }

    # Starting this point, neither valid access token were found nor successful refresh were done
    # So we start Authorization Code Flow from zero

    # ------------------------------ Authorization Code retrieval ------------------------------
    # STEP 1 : Prepare
    $EncodedRedirectUri = [System.Web.HTTPUtility]::UrlEncode($Application.RedirectUri)
    $EncodedScopes = @( # requesting all existing scopes
        'ugc-image-upload',
        'playlist-modify-public',
        'playlist-read-private',
        'playlist-modify-private',
        'playlist-read-collaborative',
        'app-remote-control',
        'streaming',
        'user-read-playback-position',
        'user-read-recently-played',
        'user-top-read',
        'user-follow-modify',
        'user-follow-read',
        'user-read-playback-state',
        'user-read-currently-playing',
        'user-modify-playback-state',
        'user-library-read',
        'user-library-modify',
        'user-read-private',
        'user-read-email'
    ) -join '%20'
    $State = (New-Guid).ToString()

    $Uri = 'https://accounts.spotify.com/authorize'
    $Uri += "?client_id=$($Application.ClientId)"
    $Uri += '&response_type=code'
    $Uri += "&redirect_uri=$EncodedRedirectUri"
    $Uri += "&state=$State"
    $Uri += "&scope=$EncodedScopes"

    # Create an Http Server
    $Listener = [System.Net.HttpListener]::new() 
    $Prefix = $Application.RedirectUri.Substring(0, $Application.RedirectUri.LastIndexOf('/') + 1) # keep uri until the last '/' included
    $Listener.Prefixes.Add($Prefix)
    $Listener.Start()
    if ($Listener.IsListening) {
        Write-Verbose 'HTTP Server is ready to receive Authorization Code'
        $HttpServerReady = $true
    }
    else {
        Write-Verbose 'HTTP Server is not ready. Fall back to manual method'
        $HttpServerReady = $false
    }


    # STEP 2 : Open browser to get Authorization
    if ($IsMacOS) {
        Write-Verbose 'Open Mac OS browser'
        open $URI
    }
    elseif ($IsLinux) {
        Write-Verbose 'Open Linux browser'
        Write-Verbose 'You should have a freedesktop.org-compliant desktop'
        Start-Process xdg-open $URI
    }
    else {
        # So we are on Windows
        Write-Verbose 'Open Windows browser'
        rundll32 url.dll, FileProtocolHandler $URI
    }


    # STEP 3 : Get response
    if ($httpServerReady) {
        Write-Host 'Waiting 30sec for authorization acceptance'
        $Task = $null
        $StartTime = Get-Date
        while ($Listener.IsListening -and ((Get-Date) - $StartTime) -lt '0.00:00:30' ) {
    
            if ($null -eq $Task) {
                $task = $Listener.GetContextAsync()
            }
    
            if ($Task.IsCompleted) {
                $Context = $task.Result
                $Task = $null
                $Response = $context.Request.Url
                $ContextResponse = $context.Response
    
                [string]$html = '<script>close()</script>Thanks! You can close this window now.'
    
                $htmlBuffer = [System.Text.Encoding]::UTF8.GetBytes($html) # convert html to bytes
    
                $ContextResponse.ContentLength64 = $htmlBuffer.Length
                $ContextResponse.OutputStream.Write($htmlBuffer, 0, $htmlBuffer.Length)
                $ContextResponse.OutputStream.Close()
                break;
            }
        }
        $Listener.Stop()
    }
    else {
        $Response = Read-Host 'Paste the entire URL that it redirects you to'
        $Response = [System.Uri]$Response
    }

    # STEP 4 : Check and Parse response
    # check Response
    if ($Response.OriginalString -eq '') {
        Throw 'Response of Authorization Code retrieval can''t be empty'
    }

    # parse query
    $ResponseQuery = [System.Web.HttpUtility]::ParseQueryString($Response.Query)

    # check state
    if ($ResponseQuery['state'] -ne $State) {
        Throw 'State returned during Authorization Code retrieval doesn''t match state passed'
    }

    # check if an error has been returned
    if ($ResponseQuery['error']) {
        Throw "Error occured during Authorization Code retrieval : $($ResponseQuery['error'])"
    }
    
    # all checks are passed, we should have the code
    if ($ResponseQuery['code']) {
        $AuthorizationCode = $ResponseQuery['code']
    }
    else {
        Throw 'Authorization Code not returned during Authorization Code retrieval'
    }

    # Authorization Code is in $AuthorizationCode

    # ------------------------------ Token retrieval ------------------------------
    # STEP 1 : Prepare
    $Uri = 'https://accounts.spotify.com/api/token'
    $Method = 'Post'
    $Body = @{
        grant_type    = 'authorization_code'
        code          = $AuthorizationCode
        redirect_uri  = $Application.RedirectUri
        client_id     = $Application.ClientId # alternative way to send the client id and secret
        client_secret = $Application.ClientSecret # alternative way to send the client id and secret
    }

    # STEP 2 : Make request to the Spotify Accounts service
    try {
        Write-Verbose 'Send request to get access token.'
        $CurrentTime = Get-Date
        $Response = Invoke-WebRequest -Uri $Uri -Method $Method -Body $Body
    }
    catch {
        Throw "Error occured during request of access token : $($PSItem[0].ToString())"
    }

    # STEP 3 : Parse and save response
    $ResponseContent = $Response.Content | ConvertFrom-Json

    $Token = @{
        access_token  = $ResponseContent.access_token
        token_type    = $ResponseContent.token_type
        scope         = $ResponseContent.scope
        expires       = $CurrentTime.AddSeconds($ResponseContent.expires_in).ToString('u')
        refresh_token = $ResponseContent.refresh_token
    }

    Set-SpotifyApplication -Name $ApplicationName -Token $Token
    Write-Verbose 'Successfully saved Token'

    return $Token.access_token
}