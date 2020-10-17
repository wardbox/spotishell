function Get-FollowedArtists {
    <#
    .SYNOPSIS
      Fetches followed artists on the current user's profile
    .DESCRIPTION
      Grabs artist data for all followed artists for the user authed under the current access token
    .EXAMPLE
      PS C:\> Get-FollowedArtists -Username "xyz"
      Grabs data of all followed artist and returns them in a list
    .PARAMETER Username
      This should be a string.
      You get this from running Get-SpotifyUserAccessToken
    #>
    param(
        # UserAccessToken
        [Parameter(Mandatory)]
        [String]
        $Username
    )

    Write-Verbose 'Attempting to return all followed artists.'
    $Method = 'Get'
    $AccessToken = Get-SpotifyUserAccessToken -Username $Username
    $Auth = @{Authorization = "Bearer $($AccessToken.access_token)" }
    $Uri = 'https://api.spotify.com/v1/me/following?type=artist&limit=50'

    # build a fake Response to start the machine
    $Response = @{artists = @{next = $Uri } }

    While ($Response.artists.next) {
        $Response = Send-SpotifyCall -Method $Method -Uri $Response.artists.next -Header $Auth -ErrorAction Stop
        $Response.artists.items # this return items that will be aggregated with items of other loops
    }
}