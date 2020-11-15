<#
    .SYNOPSIS
        Check to see if the current user is following one or more other Spotify users.
    .EXAMPLE
        PS C:\> Test-FollowedUser -Id "blahblahblah"
        Check to see if the current user follows the user with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Test-FollowedUser -Id 'blahblahblah','blahblahblah2'
        Check to see if the current user follows both specified users from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Test-FollowedUser
        Check to see if the current user follows both specified users from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Id
        One or more User Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-FollowedUser {
  param (
      [Parameter(Mandatory, ValueFromPipeline)]
      [ValidateNotNullOrEmpty()]
      [array]
      $Id,

      [string]
      $ApplicationName
  )

  $Method = 'Get'

  for ($i = 0; $i -lt $Id.Count; $i += 50) {

      $Uri = 'https://api.spotify.com/v1/me/following/contains?type=user&ids=' + ($Id[$i..($i + 49)] -join '%2C')
      Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
  }
}