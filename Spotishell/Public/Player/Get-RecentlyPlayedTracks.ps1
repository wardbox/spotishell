<#
    .SYNOPSIS
        Get tracks from the current user's recently played tracks.
    .EXAMPLE
        PS C:\> Get-RecentlyPlayed
        Retrieves the recently played tracks
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
    .PARAMETER Limit
        Specifies how many entries to fetch. 
        Allowed range is 1 through 50.
    .PARAMETER BeforeTimestamp
        Returns all items before (but not including) this cursor position. If before is specified, after must not be specified.
    .PARAMETER AfterTimestamp
        Returns all items after (but not including) this cursor position. If after is specified, before must not be specified.
    .NOTES
        Returns the most recent 50 tracks played by a user.
        Note that a track currently playing will not be visible in play history until it has completed.
        A track must be played for more than 30 seconds to be included in play history.
#>
function Get-RecentlyPlayedTracks {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param(
        [string]
        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'BeforeTimestamp')]
        [Parameter(ParameterSetName = 'AfterTimestamp')]
        $ApplicationName,

        [int]
        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'BeforeTimestamp')]
        [Parameter(ParameterSetName = 'AfterTimestamp')]
        [ValidateRange(1, 50)]
        $Limit = 50,

        [nullable[datetime]]
        [Parameter(ParameterSetName = 'BeforeTimestamp')]
        $BeforeTimestamp = $null,

        [nullable[datetime]]
        [Parameter(ParameterSetName = 'AfterTimestamp')]
        $AfterTimestamp = $null
    )

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