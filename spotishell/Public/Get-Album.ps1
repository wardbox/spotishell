function Get-Album {
  <#
.SYNOPSIS
    Gets an album.
.DESCRIPTION
    Gets an album with a specific spotify Id, only takes one
.EXAMPLE
    PS C:\> Get-Album -Id "blahblahblah"
    Retrieves an album from spotify with the Id of "blahblahblah"
.PARAMETER Id
    Should be a string.
#>
  param (
    # Id of the album we want to get information on
    [Parameter(Mandatory)]
    [string]
    $Id
  )
  Write-Verbose "Attempting to return info on album with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/albums/" + $Id

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
    return $Response
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-Album"
  }
}