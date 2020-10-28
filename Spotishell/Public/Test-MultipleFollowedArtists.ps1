function Test-MultipleFollowedArtists {
  <#
    .SYNOPSIS
      Check if current user follows some Artists
    .EXAMPLE
      PS C:\> Test-MultipleFollowedArtists -Username "xyz" -ArtistArray @("id1","id2")
      Check to see if the user authed under the current access token follow artists with Ids "id1" and "id2"
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

  Write-Verbose "Checking follow of those artists"
  $Method = "Get"
  $Uri = "https://api.spotify.com/v1/me/following/contains?type=artist&ids=$($ArtistArray -join '%2C')"
  $AccessToken = Get-SpotifyUserAccessToken -Username $Username
  $Auth = @{
    Authorization = "Bearer $($AccessToken.access_token)"
  }
  
  Send-SpotifyCall -Method $Method -Uri $Uri -Header $Auth -ErrorAction Stop
}