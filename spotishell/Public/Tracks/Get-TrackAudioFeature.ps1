<#
    .SYNOPSIS
        Get audio features for one or more tracks based on their Spotify IDs.
    .EXAMPLE
        PS C:\> Get-TrackAudioFeature -Id 'blahblahblah'
        Retrieves audio features for track from Spotify with the Id of 'blahblahblah'
    .EXAMPLE
        PS C:\> Get-TrackAudioFeature -Ids 'blahblahblah','blahblahblah2'
        Retrieves audio features for both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .EXAMPLE
        PS C:\> @('blahblahblah','blahblahblah2') | Get-TrackAudioFeature
        Retrieves audio features for both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'
    .PARAMETER Ids
        One or more Track Ids
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-TrackAudioFeature {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [Alias('Id')]
        [array]
        $Ids,

        [string]
        $ApplicationName
    )

    $Method = 'Get'

    for ($i = 0; $i -lt $Ids.Count; $i += 100) {

        $Uri = 'https://api.spotify.com/v1/audio-features?ids=' + ($Ids[$i..($i + 99)] -join '%2C')
        $Response = Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
        $Response.audio_features
    }
}