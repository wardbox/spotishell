<#
    .SYNOPSIS
        Removes saved spotify credential
    .DESCRIPTION
        Removes saved spotify credential on local machine if there is one.
    .EXAMPLE
        PS C:\> Remove-SpotifyApplication
        Remove a saved spotify application file of the name 'default'
    .EXAMPLE
        PS C:\> Remove-SpotifyApplication -Name 'dev'
        Remove a saved spotify application file of the name 'dev'
    .PARAMETER Name
        Specifies the name of the spotify application you want to remove
#>
function Remove-SpotifyApplication {

    param (
        [String]
        $Name = 'default'
    )

    $StorePath = Get-StorePath

    if (!(Test-Path -Path $StorePath)) {
        Write-Warning "No store folder at $StorePath, you need to create a Spotify Application first"
    }
    else {
        Write-Verbose "Spotify Application store exists at $StorePath"
    }

    # find and remove the named application
    $ApplicationFilePath = $StorePath + $Name + ".json"
    if (!(Test-Path -Path $ApplicationFilePath -PathType Leaf)) {
        Throw 'The specified Application doesn''t exist'
    }

    Remove-Item -Path $ApplicationFilePath
}