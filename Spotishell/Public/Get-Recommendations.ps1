function Get-Recommendations {
  <#
  .SYNOPSIS
    Gets recommendations.
  .DESCRIPTION
    Recommendations are generated based on the available information
    for a given seed entity and matched against similar artists and tracks.
    If there is sufficient information about the provided seeds, a list of
    tracks will be returned together with pool size details.
  .EXAMPLE
    PS C:\> Get-Recommendations -SeedArtists @("artist1", "artist2") -SeedGenres @("genre1") -SeedTracks @("track1")
    Retrieves recommendations based on all provided attributes
  .PARAMETER SeedArtists
    This should be a comma separated list of spotify Ids for artists.
    Up to 5 seed values may be provided in any combination of seed_artists, seed_tracks and seed_genres.
  .PARAMETER SeedGenres
    This should be a comma separated list of any genres in the set of available genre seeds. Up to 5 seed
    values may be provided in any combination of seed_artists, seed_tracks and seed_genres.
  .PARAMETER SeedTracks
    This should be a comma separated list of Spotify IDs for a seed track. Up to 5 seed values may be
    provided in any combination of seed_artists, seed_tracks and seed_genres.
  .NOTES
    Max 100 recommendations can be pulled
  #>
  param (
    # Our seed artist spotify Ids
    [array]
    $SeedArtists,

    # Our seed genres
    [array]
    $SeedGenres,

    # Our seed track spotify Ids
    [array]
    $SeedTracks,

    # The filters we want to apply
    [array]
    $Filters
  )

  $Artists = ""
  $Genres = ""
  $Tracks = ""
  $Query = ""
  $Limit = "100"

  if (!$SeedArtists -and !$SeedTracks) {
    Write-Warning "You need to supply at least 1 artist or track."
    break
  }

  while (!$SeedArtists -or !$SeedGenres -or !$SeedTracks) {
    if (!$SeedGenres) {
      if ($SeedArtists) {
        foreach ($Id in $SeedArtists) {
          $ArtistObject = Get-Artist -Id $Id
          $SeedGenres += $ArtistObject.genres[0]
        }
      } elseif ($SeedTracks) {
        foreach ($Track in $SeedTracks) {
          $TrackObject = Get-Track -Id $Track
          $ArtistObject = Get-Artist -Id $TrackObject.artists[0].id
          $SeedGenres += $ArtistObject.genres[0]
        }
      }
    }

    if (!$SeedTracks) {
      foreach ($Id in $SeedArtists) {
        $ArtistTopTracks = Get-ArtistTopTracks -Id $Id
        $SeedTracks += $ArtistTopTracks[0].id
      }
    }
    if (!$SeedArtists) {
      #Get artists from seedtracks
      foreach ($Track in $SeedTracks) {
        $TrackObject = Get-Track -Id $Track
        $ArtistObject = Get-Artist -Id $TrackObject.artists[0].id
        $SeedArtists += $ArtistObject.id
      }
    }
  }

  $Count = $SeedArtists.Count
  foreach ($Id in $SeedArtists) {
    if ($Count -gt 1) {
      $Artists += "$Id%2C"
    } else {
      $Artists += "$Id"
    }
    $Count--
  }

  $Count = $SeedGenres.Count
  foreach ($Name in $SeedGenres) {
    $CurrentGenre = $Name.replace(" ", "%20")
    if ($Count -gt 1) {
      $Genres += "$CurrentGenre%2C"
    } else {
      $Genres += "$CurrentGenre"
    }
    $Count--
  }

  $Count = $SeedTracks.Count
  foreach ($Id in $SeedTracks) {
    if ($Count -gt 1) {
      $Tracks += "$Id%2C"
    } else {
      $Tracks += "$Id"
    }
    $Count--
  }

  $Count = $Filters.Count
  foreach ($Filter in $Filters) {
    if ($Count -gt 1) {
      $Query += "$Filter&"
    } else {
      $Query += "$Filter"
    }
  }

  $Method = "Get"
  if ($Query) {
    $Uri = "https://api.spotify.com/v1/recommendations?limit=" + $Limit + "&seed_artists=" + $Artists + "&seed_genres=" + $Genres + "&seed_tracks=" + $Tracks + "&" + $Query
  } else {
    $Uri = "https://api.spotify.com/v1/recommendations?limit=" + $Limit + "&seed_artists=" + $Artists + "&seed_genres=" + $Genres + "&seed_tracks=" + $Tracks

  }

  $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ErrorAction Stop
  return $Response.tracks
}