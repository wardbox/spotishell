function Get-AlbumTracks {
  <#
.SYNOPSIS
    Gets album tracks.
.DESCRIPTION
    Gets album tracks with a specific spotify Id, only takes one
.EXAMPLE
    PS C:\> Get-AlbumTracks -Id "blahblahblah"
    Retrieves album tracks from spotify with the Id of "blahblahblah"
.PARAMETER Id
    This should be a string.
    Takes the album Id.
.NOTES
    Only returns a max of 50 tracks
#>
  param (
    # Id of the album we want to get information on
    [Parameter(Mandatory)]
    [string]
    $Id
  )
  Write-Verbose "Attempting to return info on album with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/albums/" + $Id + "/tracks?limit=50"

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}