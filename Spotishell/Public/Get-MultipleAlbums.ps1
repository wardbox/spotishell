function Get-MultipleAlbums {
  <#
  .SYNOPSIS
    Fetches data for multiple albums
  .DESCRIPTION
    Grabs album data for multiple albums, takes in Ids in an array
  .EXAMPLE
    PS C:\> Get-MultipleAlbums -AlbumArray @("id1","id2")
    Grabs album data for album Ids "id1" and "id2" and returns them in an object
  .PARAMETER AlbumArray
    An array of no greater than 20 album Ids
  #>
  param(
    # The array of album Ids
    [Parameter(Mandatory)]
    [array]
    $AlbumArray
  )

  if ($AlbumArray.Count -gt 20) {
    Write-Warning "Can't get more than 20 at a time."
    break
  }

  $ConstructedAlbumIds = ""

  # Construct Id string
  $Count = $AlbumArray.Count
  Write-Verbose "There are $Count album Ids to check"
  foreach ($AlbumId in $AlbumArray) {
    if ($Count -gt 1) {
      $ConstructedAlbumIds += "$AlbumId%2C"
    } else {
      $ConstructedAlbumIds += $AlbumId
    }
    $Count--
  }

  $Query = "?ids=" + $ConstructedAlbumIds

  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/albums" + $Query

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response.albums
}