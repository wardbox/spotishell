<#
    .SYNOPSIS
        Convert PSCustomObject to Hashtable
    .DESCRIPTION
        Allows to convert one or an array of PSCustomObject to one or an array of Hashtable
    .EXAMPLE
        PS C:\> Get-Content -Path $FilePath -Raw | ConvertFrom-Json | ConvertTo-Hashtable
        Read a JSON file then convert it to a hashtable easier to modify
    .PARAMETER PsCustomObject
        Specifies the (or array of) PSCustomObject to convert to Hashtable
        Can be Pipelined
#>
function ConvertTo-Hashtable {
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true
        )] [PSCustomObject] $InputObject 
    )
    Process {
        $h = @{}
        $InputObject.PSObject.properties | ForEach-Object {
            if ($_.TypeNameOfValue -eq 'System.Management.Automation.PSCustomObject') {
                $h[$_.Name] = ($_.Value | ConvertTo-Hashtable)
            }
            else {
                $h[$_.Name] = $_.Value
            }
        }
        $h
    }
}