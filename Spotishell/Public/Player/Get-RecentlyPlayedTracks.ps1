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
        $ApplicationName,

        [int]
        $Limit = 50,

        [nullable[datetime]]
        $BeforeTimestamp = $null,

        [nullable[datetime]]
        $AfterTimestamp = $null
    )

    if ($BeforeTimestamp -and $AfterTimestamp) {
        throw "Use either `BeforeTimestamp` or `AfterTimestamp`. Not both."
    }

    $Method = 'Get'
    $Uri = "https://api.spotify.com/v1/me/player/recently-played?limit=$Limit"

    if ($BeforeTimestamp) {
        $Uri += '&before=' + (Get-Date ($BeforeTimestamp.ToUniversalTime()) -UFormat %s)
    }

    if ($AfterTimestamp) {
        $Uri += '&after=' + (Get-Date ($AfterTimestamp.ToUniversalTime()) -UFormat %s)
    }

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
    $Response.items.track
}