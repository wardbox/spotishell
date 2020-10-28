<#
    .SYNOPSIS
        Create a playlist-style listening experience based on seed artists, tracks and genres.
    .DESCRIPTION
        Recommendations are generated based on the available information for a given seed entity and matched against similar artists and tracks.
        If there is sufficient information about the provided seeds, a list of tracks will be returned together with pool size details.
    .EXAMPLE
        PS C:\> Get-Recommendations -SeedArtists @('artist1', 'artist2') -SeedGenres @('genre1') -SeedTracks @('track1')
        Retrieves recommendations based on all provided attributes
    .PARAMETER SeedArtists
        Specifies a comma separated list of spotify Ids for artists.
        Up to 5 seed values may be provided in any combination of SeedArtists, SeedTracks and SeedGenres.
    .PARAMETER SeedGenres
        Specifies a comma separated list of any genres in the set of available genre seeds.
        Up to 5 seed values may be provided in any combination of SeedArtists, SeedTracks and SeedGenres.
    .PARAMETER SeedTracks
        Specifies a comma separated list of Spotify IDs for a seed track.
        Up to 5 seed values may be provided in any combination of SeedArtists, SeedTracks and SeedGenres.
    .PARAMETER OtherFilters
        Specifies a list of additional query parameters in min_*, max_* and target_* list (https://developer.spotify.com/documentation/web-api/reference/browse/get-recommendations/)
        Ex : @('min_acousticness=1.0','max_energy=1.0','min_popularity=50')
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
    .NOTES
        Max 100 recommendations can be pulled
#>
function Get-Recommendations {
    param (
        [array]
        $SeedArtists,

        [array]
        $SeedGenres,

        [array]
        $SeedTracks,

        [array]
        $OtherFilters,

        [string]
        $ApplicationName
    )

    if (!$SeedArtists -and !$SeedGenres -and !$SeedTracks) {
        Throw 'You need to supply at least 1 artist, genre or track.'
    }

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/recommendations?limit=100'
    if ($SeedArtists) { $Uri += '&seed_artists=' + [System.Web.HTTPUtility]::UrlEncode($SeedArtists -join ',') }
    if ($SeedGenres) { $Uri += '&seed_genres=' + [System.Web.HTTPUtility]::UrlEncode($SeedGenres -join ',') }
    if ($SeedTracks) { $Uri += '&seed_tracks=' + [System.Web.HTTPUtility]::UrlEncode($SeedTracks -join ',') }
    if ($OtherFilters) { $Uri += '&' + ($OtherFilters -join '&') }

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.tracks
}