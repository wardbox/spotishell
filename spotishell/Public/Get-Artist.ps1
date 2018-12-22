function Get-Artist {
  <#
.SYNOPSIS
    Gets an Artist.
.DESCRIPTION
    Gets an Artist with a specific spotify Id, only takes one
.EXAMPLE
    PS C:\> Get-Artist -Id "blahblahblah"
    Retrieves an artist from spotify with the Id of "blahblahblah"
.PARAMETER Id
    The spotify Id of the artist we want to look up
#>
  param (
    # Id of the artist we want to look up
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  Write-Verbose "Attempting to return info on artist with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/artists/" + $Id

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
    return $Response
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-Artist"
  }
}