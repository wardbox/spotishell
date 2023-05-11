<#
    .SYNOPSIS
        Change a playlist's name and public/private state. (The user must, of course, own the playlist.)
    .EXAMPLE
        PS C:\> Set-Playlist -Id 'myplaylistId' -Name 'New Playlist Name'
        Change the name of the playlist with Id 'myplaylistId'
    .PARAMETER Id
        The Spotify ID for the playlist.
    .PARAMETER Name
        Specifies the new name for the playlist
    .PARAMETER Public
        $True the playlist will be public
        $False it will be private
    .PARAMETER Collaborative
        $True the playlist will become collaborative and other users will be able to modify the playlist in their Spotify client.
        Note: You can only set collaborative to true on non-public playlists.
    .PARAMETER Description
        Value for playlist description as displayed in Spotify Clients and in the Web API.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Set-Playlist {
    param (
        [Parameter(Mandatory)]
        [string]
        $Id,

        [string]
        $Name,

        [bool]
        $Public,

        [bool]
        $Collaborative,

        [string]
        $Description,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = 'https://api.spotify.com/v1/playlists/' + $Id

    $BodyHashtable = @{}
    if ($Name) { $BodyHashtable.name = $Name }
    if ($null -ne $Public) { $BodyHashtable.public = $Public }
    if ($null -ne $Collaborative) { $BodyHashtable.collaborative = $Collaborative }
    if ($Description) { $BodyHashtable.description = $Description }
    $Body = Get-NonAsciiCharEscaped (ConvertTo-Json $BodyHashtable -Compress)

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}