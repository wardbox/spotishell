function Search-Spotify {
    param (
        # The data we want to look for
        [Parameter(Mandatory = $true)]
        $Query,

        # Artist switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Artist,

        # Album switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Album,

        # Track switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Track,

        # Playlist switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Playlist

    )

    $Query = "q=" + $Query.replace(" ", "+")

    $Filters = @()

    if ($Artist) {
        $Filters += "artist"
    } elseif ($Album) {
        $Filters += "album"
    } elseif ($Track) {
        $Filters += "track"
    } elseif ($Playlist) {
        $Filters += "playlist"
    } else {
        $Filters += "artist"
        $Filters += "album"
        $Filters += "track"
        $Filters += "playlist"
    }

    # If we have anything to filter by, we need to add this to our query first.
    if ($Filters) {
        Write-Verbose "We've got some filters, let's load up our query."
        $Query += "&type="
        $Count = $Filters.Count

        foreach ($Record in $Filters) {
            if ($Count -gt 1) {
                $Query += "$Record,"
            } else {
                $Query += $Record
            }
            Write-Verbose "Current query: $Query"
            # Decrement so we can see if we need to add a comma at the end or not, kinda dumb but easy enough
            $Count--
        }
    }

    $Method = "Get"
    $Uri = "https://api.spotify.com/v1/search" + "?" + $Query

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri
    return $Response

}