<#
    .SYNOPSIS
        Modifies an aplication credentials
    .DESCRIPTION
        Allows to modify clientId and ClientSecret of an existing Spotify application credentials
    .EXAMPLE
        PS C:\> Set-SpotifyApplication -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'
        Change the content of the default application credentials json in the store (named default.json) using new ClientId and ClientSecret provided.
    .EXAMPLE
        PS C:\> Set-SpotifyApplication -Name 'dev' -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'
        Change the content of the application credentials json named dev.json using new ClientId and ClientSecret provided.
    .PARAMETER Name
        Specifies the name of the application credentials you want to modify ('default' if not specified).
    .PARAMETER ClientId
        Specifies the new Client ID of the Spotify Application
    .PARAMETER ClientSecret
        Specifies the new Client Secret of the Spotify Application
    .PARAMETER RedirectUri
        Specifies the new redirect Uri of the Spotify Application
    .PARAMETER Token
        Specifies the new Token retrieved from the Spotify Application
#>
function Set-SpotifyApplication {

    param(
        [string]
        $Name = 'default',

        [Parameter(Mandatory, ParameterSetName = "ClientIdAndSecret")]
        [String]
        $ClientId,

        [Parameter(Mandatory, ParameterSetName = "ClientIdAndSecret")]
        [String]
        $ClientSecret,

        [Parameter(ParameterSetName = "ClientIdAndSecret")]
        [String]
        $RedirectUri,

        [Parameter(Mandatory, ParameterSetName = "Token")]
        $Token
    )

    $StorePath = Get-StorePath

    $Application = Get-SpotifyApplication -Name $Name

    # Construct filepath
    $ApplicationFilePath = $StorePath + $Application.Name + ".json"

    # Update Application
    if ($ClientId) { $Application.ClientId = $ClientId }
    if ($ClientSecret) { $Application.ClientSecret = $ClientSecret }
    if ($RedirectUri) { $Application.RedirectUri = $RedirectUri }
    if ($Token) { $Application.Token = $Token }
    
    # Try to save application to file.
    try {
        Write-Verbose "Attempting to save updated application to $ApplicationFilePath"
        ConvertTo-Json -InputObject $Application | Set-Content -Path $ApplicationFilePath -Force
        Write-Verbose "Successfully saved updated application to $ApplicationFilePath"
        if ($PSCmdlet.ParameterSetName -eq 'ClientIdAndSecret') {
            Write-Host "Don't forget to setup a Redirect URIs on your Spotify Application : $Script:REDIRECT_URI" -ForegroundColor Black -BackgroundColor Green
        }
    }
    catch {
        Throw "Failed saving application to $ApplicationFilePath : $($PSItem[0].ToString())"
    }
}