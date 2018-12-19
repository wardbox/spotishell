function Search-Spotify {
  <#
  .SYNOPSIS
    Searches spotify for anything
  .DESCRIPTION
    Searches spotify for any query.  You can specify specific ones if you want to limit results.
  .EXAMPLE
    PS C:\> Search-Spotify -Query "Adam Tell" -Artist
    Will search for just artists named Adam Tell
  .EXAMPLE
    PS C:\> Search-Spotify -Query "Party"
    Will search for anything named "Party" in spotify, except users.
  .PARAMETER Query
  This should be a string
  Our query for spotify
  .PARAMETER Artist
  This is a switch
  If selected, will search for specifically Artists
  .PARAMETER Album
  This is a switch
  If selected, will search for specifically Albums
  .PARAMETER Track
  This is a switch
  If selected, will search for specifically Tracks
  .PARAMETER Playlist
  This is a switch
  If selected, will search for specifically Playlists
  #>
  param (
    # The data we want to look for
    [Parameter(Mandatory = $true)]
    $Query,

    # Artist switch
    [Parameter(Mandatory = $false)]
    [switch]
    $Artist,

    # Album switch
    [Parameter(Mandatory = $false)]
    [switch]
    $Album,

    # Track switch
    [Parameter(Mandatory = $false)]
    [switch]
    $Track,

    # Playlist switch
    [Parameter(Mandatory = $false)]
    [switch]
    $Playlist

  )

  $Query = "q=" + $Query.replace(" ", "+")

  $Filters = @()

  if ($Artist) {
    $Filters += "artist"
  } elseif ($Album) {
    $Filters += "album"
  } elseif ($Track) {
    $Filters += "track"
  } elseif ($Playlist) {
    $Filters += "playlist"
  } else {
    $Filters += "artist"
    $Filters += "album"
    $Filters += "track"
    $Filters += "playlist"
  }

  # If we have anything to filter by, we need to add this to our query first.
  if ($Filters) {
    Write-Verbose "We've got some filters, let's load up our query."
    $Query += "&type="
    $Count = $Filters.Count

    foreach ($Record in $Filters) {
      if ($Count -gt 1) {
        $Query += "$Record,"
      } else {
        $Query += $Record
      }
      Write-Verbose "Current query: $Query"
      # Decrement so we can see if we need to add a comma at the end or not, kinda dumb but easy enough
      $Count--
    }
  }

  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/search" + "?" + $Query

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri
  return $Response

}