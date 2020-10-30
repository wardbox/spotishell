function Get-MultipleAudioFeatures {
  <#
  .SYNOPSIS
    Fetches data for multiple tracks
  .DESCRIPTION
    Grabs audio feature data for multiple tracks, takes in Ids in an array
  .EXAMPLE
    PS C:\> Get-MultipleAudioFeatures -TracksArray @("id1","id2")
    Grabs audio feature data for track Ids "id1" and "id2" and returns them in an object
  .PARAMETER TrackArray
  An array of no greater than 100 track Ids
  #>
  param(
    # The array of track Ids
    [Parameter(Mandatory)]
    [array]
    $TrackArray
  )

  if ($TrackArray.Count -gt 100) {
    Write-Warning "Can't get more than 100 at a time."
    break
  }

  $ConstructedTrackIds = ""

  # Construct Id string
  $Count = $TrackArray.Count
  Write-Verbose "There are $Count track Ids to check"
  foreach ($TrackId in $TrackArray) {
    if ($Count -gt 1) {
      $ConstructedTrackIds += "$TrackId%2C"
    } else {
      $ConstructedTrackIds += $TrackId
    }
    $Count--
  }

  $Query = "?ids=" + $ConstructedTrackIds

  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/audio-features" + $Query

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}