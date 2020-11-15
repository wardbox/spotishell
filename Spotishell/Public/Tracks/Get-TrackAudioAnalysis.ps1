<#
    .SYNOPSIS
        Get a detailed audio analysis for a single track identified by its unique Spotify ID.
    .EXAMPLE
        PS C:\> Get-TrackAudioAnalysis -Id 'blahblahblah'
        Retrieves audio analysis for a track from spotify with the Id of 'blahblahblah'
    .PARAMETER Id
        The Spotify ID for the track.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Get-TrackAudioAnalysis {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $ApplicationName
    )

    $Method = 'Get'
    $Uri = 'https://api.spotify.com/v1/audio-analysis/' + $Id

    Send-SpotifyCall -Method $Method -Uri $Uri -ApplicationName $ApplicationName
}