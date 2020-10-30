function Get-Track {
  <#
  .SYNOPSIS
    Gets a track.
  .DESCRIPTION
    Gets a track with a specific spotify Id, only takes one
  .EXAMPLE
    PS C:\> Get-Track -Id "blahblahblah"
    Retrieves a track from spotify with the Id of "blahblahblah"
  .PARAMETER Id
    The spotify Id of the track we want to look up
  #>
  param (
    # Id of the track we want to look up
    [Parameter(Mandatory)]
    [string]
    $Id
  )

  Write-Verbose "Attempting to return info on track with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/tracks/" + $Id

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}