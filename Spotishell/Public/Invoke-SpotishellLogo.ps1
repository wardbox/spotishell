<#
    .SYNOPSIS
        Display a ascii spotishell logo on screen.
    .EXAMPLE
        PS C:\> Invoke-Ascii
        Display a ascii spotishell logo on screen.
#>
function Invoke-SpotishellLogo { 

    Write-Host -ForegroundColor Green "    
         _______  _______  _______  _______  ___   _______  __   __  _______  ___      ___     
        |       ||       ||       ||       ||   | |       ||  | |  ||       ||   |    |   |    
        |  _____||    _  ||   _   ||_     _||   | |  _____||  |_|  ||    ___||   |    |   | 
        | |_____ |   |_| ||  | |  |  |   |  |   | | |_____ |       ||   |___ |   |    |   |  
        |_____  ||    ___||  |_|  |  |   |  |   | |_____  ||       ||    ___||   |___ |   |___
         _____| ||   |    |       |  |   |  |   |  _____| ||   _   ||   |___ |       ||       |
        |_______||___|    |_______|  |___|  |___| |_______||__| |__||_______||_______||_______|        
        https://github.com/wardbox/spotishell
        "
   
}
