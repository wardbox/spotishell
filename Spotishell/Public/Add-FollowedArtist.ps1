function Add-FollowedArtist {
    <#
  .SYNOPSIS
    Follow a new Artist
  .EXAMPLE
    PS C:\> Add-FollowedArtist -Username "xyz" -Id "blahblahblah"
    Add the artist with the Id of "blahblahblah" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER Id
    The spotify Id of the artist we want to follow
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
    Write-Verbose "Attempting to follow this artist"
    $Method = "Put"
    $Uri = "https://api.spotify.com/v1/me/following?type=artist&ids=$Id"
    $AccessToken = Get-SpotifyUserAccessToken -Username $Username
    $Auth = @{
        Authorization = "Bearer $($AccessToken.access_token)"
    }

    Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}