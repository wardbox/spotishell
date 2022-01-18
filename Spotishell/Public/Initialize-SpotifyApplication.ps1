<#
    .SYNOPSIS
        Initializes Spotify Application
    .DESCRIPTION
        Initializes Spotify Application by retrieving and storing Spotify Access Token for an Application if it is missing or invalid in the local store
        The retrieval process follows the Authorization Code Flow (https://developer.spotify.com/documentation/general/guides/authorization-guide/#authorization-code-flow)
    .EXAMPLE
        PS C:\> Initialize-SpotifyApplication -ApplicationName 'dev'
        Looks for the Access Token of the Application named 'dev' and runs the Authorization Code Flow if it's missing or invalid
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Initialize-SpotifyApplication {

    [CmdletBinding()]
    param (
        [String]
        $ApplicationName
    )

    if ($null -ne (Get-SpotifyAccessToken -ApplicationName $ApplicationName) -and $null -ne (Get-CurrentUserProfile -ApplicationName $ApplicationName)) {
        Write-Host 'Your Spotify Application is correctly initialized. You''re good to go!' -BackgroundColor Green -ForegroundColor Black
    }
    else {
        Write-Host 'Something wrong happened during initialization. Please, try again.' -BackgroundColor Red -ForegroundColor Black
    }
}