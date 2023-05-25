<#
    .SYNOPSIS
        Create a playlist for a Spotify user. (The playlist will be empty until you add tracks.)
    .EXAMPLE
        PS C:\> New-Playlist -UserId (Get-CurrentUserProfile).id -Name 'New Playlist'
        Create a new playlist named 'New Playlist'
    .PARAMETER UserId
        Specifies the user's Spotify user ID.
    .PARAMETER Name
        The name for the new playlist
        This name does not need to be unique; a user may have several playlists with the same name.
    .PARAMETER Public
        $True the playlist will be public (default)
        $False it will be private
    .PARAMETER Collaborative
        $True the playlist will be collaborative.
        $False the playlist will not be collaborative (default)
        Note that to create a collaborative playlist you must also set Public to false .
    .PARAMETER Description
        Value for playlist description as displayed in Spotify Clients and in the Web API.
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function New-Playlist {
    param (
        [Parameter(Mandatory)]
        [string]
        $UserId,

        [Parameter(Mandatory)]
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

    $Method = 'Post'
    $Uri = "https://api.spotify.com/v1/users/$UserId/playlists"

    $BodyHashtable = @{}
    if ($Name) { $BodyHashtable.name = $Name }
    if ($null -ne $Public) { $BodyHashtable.public = $Public }
    if ($null -ne $Collaborative) { $BodyHashtable.collaborative = $Collaborative }
    if ($Description) { $BodyHashtable.description = $Description }
    $Body = Get-NonAsciiCharEscaped (ConvertTo-Json $BodyHashtable -Compress)

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}