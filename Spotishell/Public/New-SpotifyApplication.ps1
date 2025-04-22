<#
    .SYNOPSIS
        Creates a new application
    .DESCRIPTION
        Creates a new application and saves it locally (file) so you may re-use it without setting it every time
    .EXAMPLE
        PS C:\> New-SpotifyApplication -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'
        Creates the default application json in the store, named default.json and containing default as Name, ClientId and ClientSecret.
    .EXAMPLE
        PS C:\> New-SpotifyApplication -Name 'dev' -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'
        Creates a new application json in the store, named dev.json and containing Name, ClientId and ClientSecret.
    .PARAMETER Name
        Specifies the name of the application you want to save ('default' if not specified).
    .PARAMETER ClientId
        Specifies the Client ID of the Spotify Application
    .PARAMETER ClientSecret
        Specifies the Client Secret of the Spotify Application
    .PARAMETER RedirectUri
        Specifies the Redirect Uri of the Spotify Application
#>
function New-SpotifyApplication {

    param (
        [String]
        $Name = 'default',

        [Parameter(Mandatory)]
        [String]
        $ClientId,

        [Parameter(Mandatory)]
        [String]
        $ClientSecret,

        [String]
        $RedirectUri = 'http://127.0.0.1:8080/spotishell'
    )

    $StorePath = Get-StorePath

    if (!(Test-Path -Path $StorePath)) {

        # There is no Spotishell store, let's try to make one.
        try {
            Write-Verbose "Attempting to create Spotishell store at $StorePath"
            New-Item -Path $StorePath -ItemType Directory -ErrorAction Stop | Out-Null
            Write-Verbose "Successfully created Spotishell store at $StorePath"
        }
        catch {
            Throw "Failed attempting to create Spotishell store at $StorePath : $($PSItem[0].ToString())"
        }
    }
    else {
        Write-Verbose "Spotishell store exists at $StorePath"
    }

    # Construct filepath
    $ApplicationFilePath = $StorePath + $Name + ".json"

    if (Test-Path -Path $ApplicationFilePath -PathType Leaf) {
        Throw 'The specified Application already exists'
    }

    # Assemble Application
    $Application =  @{
        Name         = $Name
        ClientId     = $ClientId
        ClientSecret = $ClientSecret
        RedirectUri  = $RedirectUri
    }

    # Try to save application to file.
    try {
        Write-Verbose "Attempting to save application to $ApplicationFilePath"
        ConvertTo-Json -InputObject $Application | Set-Content -Path $ApplicationFilePath
        Write-Verbose "Successfully saved application to $ApplicationFilePath"
        Write-Host "Don't forget to setup a Redirect URIs on your Spotify Application : $($Application.RedirectUri)" -ForegroundColor Black -BackgroundColor Green
        return $Application
    }
    catch {
        Throw "Failed saving application to $ApplicationFilePath : $($PSItem[0].ToString())"
    }
}