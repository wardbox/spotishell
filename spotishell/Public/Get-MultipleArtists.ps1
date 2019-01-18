function Get-MultipleArtists {
  <#
  .SYNOPSIS
    Fetches data for multiple artists
  .DESCRIPTION
    Grabs artist data for multiple artists, takes in Ids in an array
  .EXAMPLE
    PS C:\> Get-MultipleArtists -ArtistArray @("id1","id2")
    Grabs artist data for artist Ids "id1" and "id2" and returns them in an object
  .PARAMETER ArtistArray
    An array of no greater than 50 artist Ids
  #>
  param(
    # The array of artist Ids
    [Parameter(Mandatory)]
    [array]
    $ArtistArray
  )

  if ($ArtistArray.Count -gt 50) {
    Write-Warning "Can't get more than 50 at a time."
    break
  }

  $ConstructedArtistIds = ""

  # Construct Id string
  $Count = $ArtistArray.Count
  Write-Verbose "There are $Count artist Ids to check"
  foreach ($ArtistId in $ArtistArray) {
    if ($Count -gt 1) {
      $ConstructedArtistIds += "$ArtistId%2C"
    } else {
      $ConstructedArtistIds += $ArtistId
    }
    $Count--
  }

  $Query = "?ids=" + $ConstructedArtistIds

  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/artists" + $Query

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response
}