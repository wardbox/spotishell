<#
    .SYNOPSIS
        Get tracks from the current user's recently played tracks.
    .EXAMPLE
        PS C:\> Get-RecentlyPlayed
        Retrieves the recently played tracks
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
    .NOTES
        Returns the most recent 50 tracks played by a user.
        Note that a track currently playing will not be visible in play history until it has completed.
        A track must be played for more than 30 seconds to be included in play history.
#>
function Get-RecentlyPlayedTracks {
    param(
        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/player/recently-played?limit=50'

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.items.track
}