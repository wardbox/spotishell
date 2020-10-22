<#
    .SYNOPSIS
        Retrieves saved spotify credential
    .DESCRIPTION
        Finds saved spotify credential on local machine if there is one.
    .EXAMPLE
        PS C:\> Get-SpotifyApplication
        Looks for a saved spotify application file of the name 'default'
    .EXAMPLE
        PS C:\> Get-SpotifyApplication -Name 'dev'
        Looks for a saved spotify application file of the name 'dev'
    .PARAMETER Name
        Specifies the name of the spotify application you're looking for
    .PARAMETER All
        Specifies that you're looking for all Spotify Application in store
#>
function Get-SpotifyApplication {

    param (
        [String]
        $Name = 'default',

        [switch]
        $All
    )

    if (!$Name) { $Name = 'default' }

    $StorePath = Get-StorePath

    if (!(Test-Path -Path $StorePath)) {
        Write-Warning "No store folder at $StorePath, you need to create a Spotify Application first"
    }
    else {
        Write-Verbose "Spotify Application store exists at $StorePath"
    }

    # if All switch is specified return all applications
    if ($All) {
        return Get-Content -Path ($StorePath + '*') -Filter '*.json' -Raw | ConvertFrom-Json | ConvertTo-Hashtable
    }
    
    # Otherwise find and return the named application
    $ApplicationFilePath = $StorePath + $Name + ".json"
    if (!(Test-Path -Path $ApplicationFilePath -PathType Leaf)) {
        Throw 'The specified Application doesn''t exist'
    }

    Return Get-Content -Path $ApplicationFilePath -Raw | ConvertFrom-Json -ErrorAction Stop | ConvertTo-Hashtable
}