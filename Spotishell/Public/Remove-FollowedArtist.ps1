function Remove-FollowedArtist {
    <#
  .SYNOPSIS
    Unfollow a new Artist
  .EXAMPLE
    PS C:\> Remove-FollowedArtist -Username "xyz" -Id "blahblahblah"
    Remove the artist with the Id of "blahblahblah" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the artist we want to unfollow
  #>
    param (
        # UserAccessToken
        [Parameter(Mandatory)]
        [String]
        $Username,
        # Id of the artist we want to follow
        [Parameter(Mandatory)]
        [string]
        $Id
    )
    Write-Verbose 'Attempting to unfollow this artist'
    $Method = 'Delete'
    $Uri = "https://api.spotify.com/v1/me/following?type=artist&ids=$Id"
    $AccessToken = Get-SpotifyUserAccessToken -Username $Username
    $Auth = @{
        Authorization = "Bearer $($AccessToken.access_token)"
    }

    Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}