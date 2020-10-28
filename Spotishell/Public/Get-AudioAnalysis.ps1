function Get-AudioAnalysis {
  <#
  .SYNOPSIS
    Gets features for a track.
  .DESCRIPTION
    Get audio feature information for a single track identified by its unique Spotify ID.
  .EXAMPLE
    PS C:\> Get-AudioAnalysis -Id "blahblahblah"
    Retrieves audio analysis for a track from spotify with the Id of "blahblahblah"
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
  $Uri = "https://api.spotify.com/v1/audio-analysis/" + $Id

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}