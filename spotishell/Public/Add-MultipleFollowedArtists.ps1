function Add-MultipleFollowedArtists {
    <#
  .SYNOPSIS
    Follow multiple new Artists
  .EXAMPLE
    PS C:\> Add-MultipleFollowedArtists -Username "xyz" -ArtistArray @("id1","id2")
    Add artists with Ids "id1" and "id2" to follow for the user authed under the current access token
  .PARAMETER Username
    This should be a string.
    You get this from running Get-SpotifyUserAccessToken
  .PARAMETER ArtistArray
    An array of no greater than 50 artist Ids
  #>
    param (
        # UserAccessToken
        [Parameter(Mandatory)]
        [String]
        $Username,
        # The array of artist Ids
        [Parameter(Mandatory)]
        [array]
        $ArtistArray
    )

    if ($ArtistArray.Count -gt 50) {
        Write-Warning "Can't follow more than 50 at a time."
        break
    }

    Write-Verbose "Attempting to follow those artists"
    $Method = "Put"
    $Uri = "https://api.spotify.com/v1/me/following?type=artist&ids=$($ArtistArray -join '%2C')"
    $AccessToken = Get-SpotifyUserAccessToken -Username $Username
    $Auth = @{
        Authorization = "Bearer $($AccessToken.access_token)"
    }

    Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop | Out-Null
}