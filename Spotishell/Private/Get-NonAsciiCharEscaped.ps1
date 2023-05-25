<#
    .SYNOPSIS
        Escape non-ASCII characters from a string
    .DESCRIPTION
        Return a string with all non-ASCII characters escaped with \uXXXX
        (implemented for PS5.1 compatibility)
        (PS6+ can use parameter EscapeHandling in ConvertTo-Json)
    .EXAMPLE
        PS C:\> Get-NonAsciiCharEscaped 'Héllö Wörld'
        Return 'H\u00e9ll\u00f6 W\u00f6rld'
    .PARAMETER InputObject
        Specifies the string to process
        Can be Pipelined
#>
function Get-NonAsciiCharEscaped {
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true
        )] [string] $InputObject
    )
    Process {
        $nonAsciiChars = $InputObject.ToCharArray() | Where-Object { $_ -match '[^\x00-\x7F]' } | Select-Object -Unique
        foreach ($char in $nonAsciiChars) {
            $InputObject = $InputObject -creplace $char, ('\u{0:x4}' -f [int]$char)
        }
        $InputObject
    }
}