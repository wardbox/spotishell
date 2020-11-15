<#
    .SYNOPSIS
        Get the current user's top artists based on calculated affinity.
    .EXAMPLE
        PS C:\> Get-CurrentUserTopArtists -TimeRange Long
        Gets top artists for user over several years
    .PARAMETER TimeRange
        Long: calculated from several years of data and including all new data as it becomes available
        Medium (default): approximately last 6 months
        Short: approximately last 4 weeks
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-CurrentUserTopArtists {
    param (
        [String]
        [ValidateSet('Long', 'Medium', 'Short')]
        $TimeRange,

        [string]
        $ApplicationName
    )
    
    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/me/top/artists?limit=50'
    if ($TimeRange) { $uri += '&time_range=' + $TimeRange.ToLower() + '_term' }
    

    # build a fake Response to start the machine
    $Response = @{next = $Uri }

    While ($Response.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.next -ApplicationName $ApplicationName
        $Response.items # this return items that will be aggregated with items of other loops
    }
}