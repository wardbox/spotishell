<#
    .SYNOPSIS
        Get Spotify catalog information about an artist’s albums.
    .EXAMPLE
        PS C:\> Get-ArtistAlbums -Id "blahblah" -Album -AppearsOn
        Retrieves an artist's albums from Spotify with the Id of "blahblahblah". This will only return albums and appears on albums.
    .PARAMETER Id
        This is the Id of the artist you want to get albums for
    .PARAMETER Album
        Filter to get Albums of this artist
    .PARAMETER Single
        Filter to get Singles of this artist
    .PARAMETER AppearsOn
        Filter to get Albums where this artist appears on
    .PARAMETER Compilation
        Filter to get Compilations of this artist
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-ArtistAlbums {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [switch]
        $Album,

        [switch]
        $Single,

        [switch]
        $AppearsOn,

        [switch]
        $Compilation,

        [string]
        $ApplicationName
    )

    Write-Verbose "Attempting to return albums by artist with Id $Id"
    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/artists/$Id/albums?limit=50"

    if ($Album -or $Single -or $AppearsOn -or $Compilation) {
        $IncludeGroups = @()
        if ($Album) { $IncludeGroups += 'album' }
        if ($Single) { $IncludeGroups += 'single' }
        if ($AppearsOn) { $IncludeGroups += 'appears_on' }
        if ($Compilation) { $IncludeGroups += 'compilation' }

        $Uri += '&' + ($IncludeGroups -join '%2C')
    }

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}
