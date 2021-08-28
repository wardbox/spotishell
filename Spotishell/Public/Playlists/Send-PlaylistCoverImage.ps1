<#
    .SYNOPSIS
        Replace the image used to represent a specific playlist.
    .EXAMPLE
        PS C:\> Send-PlaylistCoverImage -Id 'blahblahblah' -ImagePath '..\myCoverImage.jpg'
        Set cover image of the playlist with id 'blahblahblah' using '..\myCoverImage.jpg'
    .EXAMPLE
        PS C:\> Send-PlaylistCoverImage -Id 'blahblahblah' -ImageBase64 '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAcFBQYFBAcGBQYIBwcIChELCgkJChUPEAwRGBUaGRgVGBcbHichGx0lHRcYIi4iJSgpKywrGiAvMy8qMicqKyr/2wBDAQcICAoJChQLCxQqHBgcKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKir/wgARCAAWABUDAREAAhEBAxEB/8QAFgAAAwAAAAAAAAAAAAAAAAAABQYH/8QAFwEAAwEAAAAAAAAAAAAAAAAAAwQFBv/aAAwDAQACEAMQAAAAqs1kRGdedTMmOcoikj0XSSzjIl0BXdwH/8QAKxAAAwACAQMBBgcBAAAAAAAAAQIDBAUGABESFAchMTJBURMiM0RhcXJz/9oACAEBAAE/AOX8zy8HPtq9PfEw/SSFtjs8v3zw1b5UVe4DUPx957KOn2XJtVeDQ5Uufe36WDtIQRMkjuxVGkiMp8f99uuO76HIdLLYxSkixadYOPzxojFXRu31DA9crhFM7mes2uM9/VVnm+Ckq1sZpSmXUqCx8DNwQAetdyzTck3+mGFAXyMQtTG8PUDxRkKM5LxVewVvq3XsyQvp9tsf2uy2lb4v8zCJLy/pmmzDrkPGddyGEPXissiD98fLxn/DtEn4+LfY/UHuD1D2W4Iuw2e52WfjV+fFIhBLf9DGaM/WNOMIiMJrOcgEVFUBVA+AA+3X/8QAIREAAgEEAgIDAAAAAAAAAAAAAQIDAAQRMQUhEhQiUWH/2gAIAQIBAT8Au731/jjyJ0Kg5ltlOhv8qFxIgYVyCP7KMpx9GpuPFrbuFbJOM1YQskChqlgjl2KWwhHeKHVf/8QAHREAAgIDAAMAAAAAAAAAAAAAAQIAAwQRIRATIv/aAAgBAwEBPwCmj277Dgrodjpo6mK4CnkFhcjktP1EciG5vH//2Q=='
        Set a smiley cover image on the playlist with id 'blahblahblah'
    .PARAMETER Id
        Specifies the Spotify ID for the playlist.
    .PARAMETER ImagePath
        Path to a JPEG Image file to send.  (~190KB max size)
    .PARAMETER ApplicationName
        Specifies the Spotify Application Name (otherwise default is used)
#>
function Send-PlaylistCoverImage {
    param(
        [Parameter(Mandatory)]
        [string]
        $Id,

        [Parameter(Mandatory, ParameterSetName = "ImagePath")]
        [string]
        $ImagePath,

        [Parameter(Mandatory, ParameterSetName = "ImageBase64")]
        [string]
        $ImageBase64,

        [string]
        $ApplicationName
    )

    $Method = 'Put'
    $Uri = "https://api.spotify.com/v1/playlists/$Id/images"

    if ($ImagePath) {
        if ($PSVersionTable.PSVersion.Major -ge 7) {
            $Body = [Convert]::ToBase64String((Get-Content $ImagePath -AsByteStream))
        } else {
            $Body = [Convert]::ToBase64String((Get-Content $ImagePath -Encoding Byte))
        }
    }

    if ($ImageBase64) {
        $Body = $ImageBase64
    }

    Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body -ApplicationName $ApplicationName
}