function Get-ArtistAlbums {
  <#
.SYNOPSIS
    Get Spotify catalog information about an artist’s albums.
.DESCRIPTION
    Optional parameters can be specified in the query string to filter and sort the response.
.EXAMPLE
    PS C:\> Get-ArtistAlbums -Id "blahblah" -Album -AppearsOn
    Retrieves an artist's albums from spotify with the Id of "blahblahblah".  This will only return albums and appears on albums.
.PARAMETER ArtistId
    This is the Id of the artist you want to get albums for
.NOTES
    If your search returns more than 50, this will truncate it, but give you the next api call to make to get more.
    Planning to add functionality to fix this later.
#>
  param (
    # Id of the artist
    [Parameter(Mandatory)]
    [string]
    $ArtistId,

    # Choose to look up albums
    [Parameter(Mandatory = $false)]
    [switch]
    $Album,

    # Choose to look up singles
    [Parameter(Mandatory = $false)]
    [switch]
    $Single,

    # Choose to look up appears on
    [Parameter(Mandatory = $false)]
    [switch]
    $AppearsOn,

    # Choose to look up compilations
    [Parameter(Mandatory = $false)]
    [switch]
    $Compilation
  )

  $Query = ""
  $Filters = @()

  if ($Album) {
    $Filters += "album"
  } elseif ($Single) {
    $Filters += "single"
  } elseif ($AppearsOn) {
    $Filters += "appears_on"
  } elseif ($Comilation) {
    $Filters += "compilation"
  } else {
    $Filters += "album"
    $Filters += "single"
    $Filters += "appears_on"
    $Filters += "compilation"
  }

  # If we have anything to filter by, we need to add this to our query first.
  if ($Filters) {
    Write-Verbose "We've got some filters, let's load up our query."
    $Count = $Filters.Count
    $Query += "include_groups="
    foreach ($Record in $Filters) {
      if ($Count -gt 1) {
        $Query += "$Record%2C"
      } else {
        $Query += $Record
      }
      Write-Verbose "Current query: $Query"
      # Decrement so we can see if we need to add a "%2C" at the end or not, kinda dumb but easy enough
      $Count--
    }
  }

  Write-Verbose "Attempting to return albums by artist with Id $Id"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/artists/" + "$ArtistId" + "/albums"

  if ($Query) {
    $Uri += "?" + $Query
  }

  $Uri += "&limit=50"

  try {
    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
    return $Response
  } catch {
    Write-Warning "Failed sending Spotify API call for function Get-ArtistAlbums"
  }
}