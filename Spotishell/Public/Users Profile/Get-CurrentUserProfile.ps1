<#
    .SYNOPSIS
        Get info on the current user's profile
    .EXAMPLE
        PS C:\> Get-CurrentUserProfile
        Gets profile info for the user authed under the current access token
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-CurrentUserProfile {
    param (
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me'

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}