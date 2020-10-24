<#
    .SYNOPSIS
        Return the Store Path
    .DESCRIPTION
        Allows to get the store Path corresponding to current OS
    .EXAMPLE
        PS C:\> Test-Path -Path (Get-StorePath)
        Check that Store folder exists
#>
function Get-StorePath {
    if ($IsMacOS -or $IsLinux) {
        return $home + '/.spotishell/'
    }
    else {
        return $env:LOCALAPPDATA + '\spotishell\'
    }
}