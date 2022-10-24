<#
    .SYNOPSIS
        Get the saved status for the selected tracks.
    .EXAMPLE
        PS C:\> Test-UserSavedTrack -Id 7na8xV9Zf1IOQtTFbvbCKO
    .PARAMETER Id
        One or more Track Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Test-UserSavedTrack {
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

		$Uri = 'https://api.spotify.com/v1/me/tracks/contains?ids=' + ($Id[$i..($i + 49)] -join '%2C')
		$Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
		$Response
	}
}