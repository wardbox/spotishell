# Documentation for Spotishell
This is the combined documentation for the Spotishell cmdlets.
<br/>Last updated on Sunday 11/22/2020 10:56 UTC
<br/><br/>

| Cmdlet | Synopsis |
| --- | --- |
| [Add-CurrentUserSavedAlbum](#add-currentusersavedalbum) | Save one or more albums from the current user's 'Your Music' library. |
| [Add-CurrentUserSavedShow](#add-currentusersavedshow) | Save one or more shows from current Spotify user's library. |
| [Add-CurrentUserSavedTrack](#add-currentusersavedtrack) | Save one or more tracks from the current user's 'Your Music' library. |
| [Add-FollowedArtist](#add-followedartist) | Add the current user as a follower of one or more artists. |
| [Add-FollowedPlaylist](#add-followedplaylist) | Add the current user as a follower of a playlist. |
| [Add-FollowedUser](#add-followeduser) | Add the current user as a follower of one or more other Spotify users. |
| [Add-ItemInPlaybackQueue](#add-iteminplaybackqueue) | Add an item to the end of the user's current playback queue. |
| [Add-PlaylistItem](#add-playlistitem) | Add one or more items to a user's playlist. |
| [Backup-Library](#backup-library) | Backup Library items to json file (FollowedArtists, Playlists, SavedAlbums, SavedShows, SavedTracks) |
| [ConvertTo-Hashtable](#convertto-hashtable) | Convert PSCustomObject to Hashtable |
| [Edit-PlaylistOrder](#edit-playlistorder) | Reorder an item or a group of items in a playlist. |
| [Get-Album](#get-album) | Get Spotify catalog information for one or more albums identified by their Spotify IDs. |
| [Get-AlbumTracks](#get-albumtracks) | Get Spotify catalog information about an albumâ€™s tracks. |
| [Get-Artist](#get-artist) | Get Spotify catalog information for one or more artists based on their Spotify IDs. |
| [Get-ArtistAlbums](#get-artistalbums) | Get Spotify catalog information about an artistâ€™s albums. |
| [Get-ArtistRelatedArtists](#get-artistrelatedartists) | Get Spotify catalog information about artists similar to a given artist. Similarity is based on analysis of the Spotify communityâ€™s listening history. |
| [Get-ArtistTopTracks](#get-artisttoptracks) | Get Spotify catalog information about an artistâ€™s top tracks by country. |
| [Get-AvailableDevices](#get-availabledevices) | Get information about a user's available devices. |
| [Get-Category](#get-category) | Get one or more categories used to tag items in Spotify (on, for example, the Spotify playerâ€™s â€œBrowseâ€ tab). |
| [Get-CategoryPlaylists](#get-categoryplaylists) | Get a list of Spotify playlists tagged with a particular category. |
| [Get-CurrentPlaybackInfo](#get-currentplaybackinfo) | Get information about the user's current playback state, including track, track progress, and active device. |
| [Get-CurrentTrack](#get-currenttrack) | Get the object currently being played on the userâ€™s Spotify account. |
| [Get-CurrentUserPlaylists](#get-currentuserplaylists) | Get a list of the playlists owned or followed by the current Spotify user. |
| [Get-CurrentUserProfile](#get-currentuserprofile) | Get info on the current user's profile |
| [Get-CurrentUserSavedAlbums](#get-currentusersavedalbums) | Get a list of the albums saved in the current Spotify user's 'Your Music' library. |
| [Get-CurrentUserSavedShows](#get-currentusersavedshows) | Get a list of shows saved in the current Spotify user's library. |
| [Get-CurrentUserSavedTracks](#get-currentusersavedtracks) | Get a list of the songs saved in the current Spotify user's 'Your Music' library. |
| [Get-CurrentUserTopArtists](#get-currentusertopartists) | Get the current user's top artists based on calculated affinity. |
| [Get-CurrentUserTopTracks](#get-currentusertoptracks) | Get the current user's top tracks based on calculated affinity. |
| [Get-Episode](#get-episode) | Get Spotify catalog information for one or more episodes based on their Spotify IDs. |
| [Get-FeaturedPlaylists](#get-featuredplaylists) | Get a list of Spotify featured playlists (shown, for example, on a Spotify playerâ€™s â€˜Browseâ€™ tab). |
| [Get-FollowedArtists](#get-followedartists) | Get the current userâ€™s followed artists. |
| [Get-NewReleases](#get-newreleases) | Get a list of new album releases featured in Spotify (shown, for example, on a Spotify playerâ€™s â€œBrowseâ€ tab). |
| [Get-Playlist](#get-playlist) | Get a playlist owned by a Spotify user. |
| [Get-PlaylistCoverImage](#get-playlistcoverimage) | Get the current image associated with a specific playlist. |
| [Get-PlaylistItems](#get-playlistitems) | Get a playlist owned by a Spotify user. |
| [Get-RecentlyPlayedTracks](#get-recentlyplayedtracks) | Get tracks from the current user's recently played tracks. |
| [Get-RecommendationGenres](#get-recommendationgenres) | Retrieve a list of available genres seed parameter values for recommendations. |
| [Get-Recommendations](#get-recommendations) | Create a playlist-style listening experience based on seed artists, tracks and genres. |
| [Get-Show](#get-show) | Gets one or more shows. |
| [Get-ShowEpisodes](#get-showepisodes) | Get Spotify catalog information about a show's episodes. Optional parameters can be used to limit the number of episodes returned. |
| [Get-SpotifyApplication](#get-spotifyapplication) | Retrieves saved spotify credential |
| [Get-Track](#get-track) | Get Spotify catalog information for one or more tracks based on their Spotify IDs. |
| [Get-TrackAudioAnalysis](#get-trackaudioanalysis) | Get a detailed audio analysis for a single track identified by its unique Spotify ID. |
| [Get-TrackAudioFeature](#get-trackaudiofeature) | Get audio features for one or more tracks based on their Spotify IDs. |
| [Get-UserPlaylists](#get-userplaylists) | Get a list of the playlists owned or followed by a Spotify user. |
| [Get-UserProfile](#get-userprofile) | Get public profile information about a Spotify user. |
| [Invoke-NextTrack](#invoke-nexttrack) | Skips to next track in the user's queue. |
| [Invoke-PreviousTrack](#invoke-previoustrack) | Skips to previous track in the user's queue. |
| [Invoke-SeekPositionCurrentTrack](#invoke-seekpositioncurrenttrack) | Seeks to the given position in the user's currently playing track. |
| [Invoke-SpotishellLogo](#invoke-spotishelllogo) | Display a ascii spotishell logo on screen. |
| [Move-Playback](#move-playback) | Transfer playback to a new device and determine if it should start playing. |
| [New-Playlist](#new-playlist) | Create a playlist for a Spotify user. (The playlist will be empty until you add tracks.) |
| [New-SpotifyApplication](#new-spotifyapplication) | Creates a new application |
| [Remove-CurrentUserSavedAlbum](#remove-currentusersavedalbum) | Remove one or more albums from the current user's 'Your Music' library. |
| [Remove-CurrentUserSavedShow](#remove-currentusersavedshow) | Delete one or more shows from current Spotify user's library. |
| [Remove-CurrentUserSavedTrack](#remove-currentusersavedtrack) | Remove one or more tracks from the current user's 'Your Music' library. |
| [Remove-FollowedArtist](#remove-followedartist) | Remove the current user as a follower of one or more artists. |
| [Remove-FollowedPlaylist](#remove-followedplaylist) | Remove the current user as a follower of a playlist. |
| [Remove-FollowedUser](#remove-followeduser) | Remove the current user as a follower of one or more other Spotify users. |
| [Remove-PlaylistItems](#remove-playlistitems) | Remove one or more items from a user's playlist. |
| [Remove-SpotifyApplication](#remove-spotifyapplication) | Removes saved spotify credential |
| [Restore-Library](#restore-library) | Restore Library items from json file (Playlists, FollowedArtists, SavedAlbums, SavedShows, SavedTracks) |
| [Resume-Playback](#resume-playback) | Resume current playback on the user's active device. |
| [Search-Item](#search-item) | Get Spotify Catalog information about albums, artists, playlists, tracks, shows or episodes that match a keyword string. |
| [Send-PlaylistCoverImage](#send-playlistcoverimage) | Replace the image used to represent a specific playlist. |
| [Set-PlaybackVolume](#set-playbackvolume) | Set the volume for the user's current playback device. |
| [Set-Playlist](#set-playlist) | Change a playlist's name and public/private state. (The user must, of course, own the playlist.) |
| [Set-PlaylistItems](#set-playlistitems) | Replace all the items in a playlist, overwriting its existing items. |
| [Set-RepeatMode](#set-repeatmode) | Set the repeat mode for the user's playback. Options are repeat-track, repeat-context, and off. |
| [Set-ShufflePlayback](#set-shuffleplayback) | Toggle shuffle on or off for user's playback. |
| [Set-SpotifyApplication](#set-spotifyapplication) | Modifies an aplication credentials |
| [Start-Playback](#start-playback) | Start a new context on the user's active device. |
| [Suspend-Playback](#suspend-playback) | Pause playback on the user's account. |
| [Test-CurrentUserSavedAlbum](#test-currentusersavedalbum) | Check if one or more albums is already saved in the current Spotify user's 'Your Music' library. |
| [Test-CurrentUserSavedShow](#test-currentusersavedshow) | Check if one or more shows is already saved in the current Spotify user's library. |
| [Test-FollowedArtist](#test-followedartist) | Check to see if the current user is following one or more artists. |
| [Test-FollowedPlaylist](#test-followedplaylist) | Check to see if one or more Spotify users are following a specified playlist. |
| [Test-FollowedUser](#test-followeduser) | Check to see if the current user is following one or more other Spotify users. |

---
For additional help, type:
```get-help about_Spotishell``` 

## Add-CurrentUserSavedAlbum

### Synopsis
Save one or more albums from the current user's 'Your Music' library.

### Syntax
Add-CurrentUserSavedAlbum [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify album Ids that you want to save

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-CurrentUserSavedAlbum -Id 'blahblahblah'

Save the album with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Add-CurrentUserSavedAlbum -Id 'blahblahblah','blahblahblah2'

Save both albums with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Add-CurrentUserSavedAlbum

Save both albums with the Id of 'blahblahblah' for the user authed under the current Application



---
## Add-CurrentUserSavedShow

### Synopsis
Save one or more shows from current Spotify user's library.

### Syntax
Add-CurrentUserSavedShow [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify show Ids that you want to save

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-CurrentUserSavedShow -Id 'blahblahblah'

Save the show with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Add-CurrentUserSavedShow -Id 'blahblahblah','blahblahblah2'

Save both shows with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Add-CurrentUserSavedShow

Save both shows with the Id of 'blahblahblah' for the user authed under the current Application



---
## Add-CurrentUserSavedTrack

### Synopsis
Save one or more tracks from the current user's 'Your Music' library.

### Syntax
Add-CurrentUserSavedTrack [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify track Ids that you want to save

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-CurrentUserSavedTrack -Id 'blahblahblah'

Save the track with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Add-CurrentUserSavedTrack -Id 'blahblahblah','blahblahblah2'

Save both tracks with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Add-CurrentUserSavedTrack

Save both tracks with the Id of 'blahblahblah' for the user authed under the current Application



---
## Add-FollowedArtist

### Synopsis
Add the current user as a follower of one or more artists.

### Syntax
Add-FollowedArtist [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify artist Ids that you want to follow

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-FollowedArtist -Id 'blahblahblah'

Add the artist with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Add-FollowedArtist -Id 'blahblahblah','blahblahblah2'

Add both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Add-FollowedArtist

Add both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application



---
## Add-FollowedPlaylist

### Synopsis
Add the current user as a follower of a playlist.

### Syntax
Add-FollowedPlaylist [-Id] <String> [[-Public] <Boolean>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The spotify Id of the playlist we want to follow

	-Public <Boolean>
	    If true the playlist will be included in userâ€™s public playlists, if false it will remain private

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-FollowedPlaylist -Id 'blahblahblah'

Add the playlist with the Id of 'blahblahblah' to follow for the user authed under the current application



---
## Add-FollowedUser

### Synopsis
Add the current user as a follower of one or more other Spotify users.

### Syntax
Add-FollowedUser [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify user Ids that you want to follow

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-FollowedUser -Id 'blahblahblah'

Add the user with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Add-FollowedUser -Id 'blahblahblah','blahblahblah2'

Add both users with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Add-FollowedUser

Add both users with the Id of 'blahblahblah' to follow for the user authed under the current Application



---
## Add-ItemInPlaybackQueue

### Synopsis
Add an item to the end of the user's current playback queue.

### Syntax
Add-ItemInPlaybackQueue [-ItemUri] <String> [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ItemUri <String>
	    The uri of the item to add to the queue. Must be a track or an episode uri.

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-ItemInPlaybackQueue

Skips to next song for user with username "blahblah"



---
## Add-PlaylistItem

### Synopsis
Add one or more items to a user's playlist.

### Syntax
Add-PlaylistItem [-Id] <String> [-ItemId] <Array> [[-Position] <Int32>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The Spotify ID for the playlist.

	-ItemId <Array>
	    Specifies the list of Spotify URIs to add, can be track or episode URIs.

	-Position <Int32>
	    Specifies the position to insert the items, a zero-based index.
	    If omitted, the items will be appended to the playlist.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Add-PlaylistItem -Id 'myPlaylistId' -ItemId 'blahblahblah'

Add the Item with the Id of 'blahblahblah' to the playlist with Id 'myPlaylistId'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Add-PlaylistItem -Id 'myPlaylistId' -ItemId 'blahblahblah','blahblahblah2'

Add both items with the Id of 'blahblahblah' to the playlist with Id 'myPlaylistId'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Add-PlaylistItem -Id

Add both items with the Id of 'blahblahblah' to the playlist with Id 'myPlaylistId'



---
## Backup-Library

### Synopsis
Backup Library items to json file (FollowedArtists, Playlists, SavedAlbums, SavedShows, SavedTracks)

### Syntax
Backup-Library [-Path] <String> [[-Type] <Array>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Path <String>
	    Path of the backup file you want to create

	-Type <Array>
	    One or more items type to backup (All, FollowedArtists, SavedAlbums, SavedShows, SavedTracks)

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Backup-Library -Path '.\mySpotifyBackup.json'

Backup all Library items into '.\mySpotifyBackup.json'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Backup-Library -Type FollowedArtists,SavedAlbums -Path '.\mySpotifyBackup.json'

Backup Followed Artists and Saved Albums items into '.\mySpotifyBackup.json'



---
## ConvertTo-Hashtable

### Synopsis
Convert PSCustomObject to Hashtable

### Syntax
ConvertTo-Hashtable [-InputObject] <PSObject> [<CommonParameters>]

### Description
Allows to convert one or an array of PSCustomObject to one or an array of Hashtable

### Parameters

	-InputObject <PSObject>

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Content -Path $FilePath -Raw | ConvertFrom-Json | ConvertTo-Hashtable

Read a JSON file then convert it to a hashtable easier to modify



---
## Edit-PlaylistOrder

### Synopsis
Reorder an item or a group of items in a playlist.

### Syntax
Edit-PlaylistOrder [-Id] <String> [-RangeStart] <Int32> [[-RangeLength] <Int32>] [-InsertBefore] <Int32> [[-SnapshotId] <String>] [[-ApplicationName] <String>] 
[<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify ID for the playlist.

	-RangeStart <Int32>
	    Specifies the position of the first item to be reordered.

	-RangeLength <Int32>
	    Specifies the amount of items to be reordered. Defaults to 1 if not set.
	    The range of items to be reordered begins from the range_start position, and includes the range_length subsequent items.

	-InsertBefore <Int32>
	    Specifies the position where the items should be inserted.
	    To reorder the items to the end of the playlist, simply set insert_before to the position after the last item.

	-SnapshotId <String>
	    Specifies the playlistâ€™s snapshot ID against which you want to make the changes.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Edit-PlaylistOrder -Id 'blahblahblah' -RangeStart 0 -InsertBefore 4

Moves the first item to the fifth position in the playlist with id 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Edit-PlaylistOrder -Id 'blahblahblah' -RangeStart 1 -RangeLength 2 -InsertBefore 3

Moves the second and third items to the fourth position in the playlist with id 'blahblahblah'



---
## Get-Album

### Synopsis
Get Spotify catalog information for one or more albums identified by their Spotify IDs.

### Syntax
Get-Album [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Album Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Album -Id 'blahblahblah'

Retrieves an album from Spotify with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-Album -Id 'blahblahblah','blahblahblah2'

Retrieves both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Get-Album

Retrieves both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Get-AlbumTracks

### Synopsis
Get Spotify catalog information about an albumâ€™s tracks.

### Syntax
Get-AlbumTracks [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the album Id

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-AlbumTracks -Id 'blahblahblah'

Retrieves album tracks from spotify album with the Id of "blahblahblah"



---
## Get-Artist

### Synopsis
Get Spotify catalog information for one or more artists based on their Spotify IDs.

### Syntax
Get-Artist [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Artist Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Artist -Id 'blahblahblah'

Retrieves an artist from Spotify with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-Artist -Id 'blahblahblah','blahblahblah2'

Retrieves both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Get-Artist

Retrieves both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Get-ArtistAlbums

### Synopsis
Get Spotify catalog information about an artistâ€™s albums.

### Syntax
Get-ArtistAlbums [-Id] <String> [-Album] [-Single] [-AppearsOn] [-Compilation] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    This is the Id of the artist you want to get albums for

	-Album <SwitchParameter>
	    Filter to get Albums of this artist

	-Single <SwitchParameter>
	    Filter to get Singles of this artist

	-AppearsOn <SwitchParameter>
	    Filter to get Albums where this artist appears on

	-Compilation <SwitchParameter>
	    Filter to get Compilations of this artist

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-ArtistAlbums -Id "blahblah" -Album -AppearsOn

Retrieves an artist's albums from Spotify with the Id of "blahblahblah". This will only return albums and appears on albums.



---
## Get-ArtistRelatedArtists

### Synopsis
Get Spotify catalog information about artists similar to a given artist. Similarity is based on analysis of the Spotify communityâ€™s listening history.

### Syntax
Get-ArtistRelatedArtists [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The Id of the artist we want to look up

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-ArtistRelatedArtists -Id 'blahblahblah'

Retrieves artists related to artist with Id of 'blahblahblah'



---
## Get-ArtistTopTracks

### Synopsis
Get Spotify catalog information about an artistâ€™s top tracks by country.

### Syntax
Get-ArtistTopTracks [-Id] <String> [[-Country] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The artist's Spotify Id

	-Country <String>
	    Specifies the country (ISO 3166-1 Alpha-2) of top tracks listing. (otherwise Country of Spotify account)

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-ArtistTopTracks -Id 'blahblahblah'

Retrieves top tracks by artist with Id 'blahblahblah' in your country




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-ArtistTopTracks -Id 'blahblahblah' -Country 'US'

Retrieves top tracks by artist with Id 'blahblahblah' in the market 'US'



---
## Get-AvailableDevices

### Synopsis
Get information about a user's available devices.

### Syntax
Get-AvailableDevices [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-AvailableDevices

Retrieves list of available devices



---
## Get-Category

### Synopsis
Get one or more categories used to tag items in Spotify (on, for example, the Spotify playerâ€™s â€œBrowseâ€ tab).

### Syntax
Get-Category [[-Id] <String>] [[-Country] <String>] [[-Locale] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the category's Id we want to pull info on.

	-Country <String>
	    Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
	    Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
	    Ex : FR

	-Locale <String>
	    Specifies the desired language
	    Uses an "ISO 639-1" language code and an "ISO 3166-1 alpha-2" country code, joined by an underscore
	    Ex : es_MX    meaning Spanish (Mexico)

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Category -Id 'toplists'

Retrieves details on a specific category with Id 'toplists'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-Category

Retrieves details on all categories



---
## Get-CategoryPlaylists

### Synopsis
Get a list of Spotify playlists tagged with a particular category.

### Syntax
Get-CategoryPlaylists [-Id] <String> [[-Country] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The Id of the category we want to pull info on.

	-Country <String>
	    Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
	    Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
	    Ex : FR

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CategoryPlaylists 'toplists'

Retrieves details on a specific category with Id "toplists"



---
## Get-CurrentPlaybackInfo

### Synopsis
Get information about the user's current playback state, including track, track progress, and active device.

### Syntax
Get-CurrentPlaybackInfo [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentPlaybackInfo

Retrieves the current playback status



---
## Get-CurrentTrack

### Synopsis
Get the object currently being played on the userâ€™s Spotify account.

### Syntax
Get-CurrentTrack [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentTrack

Retrieves the current playing track



---
## Get-CurrentUserPlaylists

### Synopsis
Get a list of the playlists owned or followed by the current Spotify user.

### Syntax
Get-CurrentUserPlaylists [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserPlaylists

Grabs data of all current user's playlists



---
## Get-CurrentUserProfile

### Synopsis
Get info on the current user's profile

### Syntax
Get-CurrentUserProfile [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserProfile

Gets profile info for the user authed under the current access token



---
## Get-CurrentUserSavedAlbums

### Synopsis
Get a list of the albums saved in the current Spotify user's 'Your Music' library.

### Syntax
Get-CurrentUserSavedAlbums [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserSavedAlbums

Grabs data of all saved albums and returns them in a list



---
## Get-CurrentUserSavedShows

### Synopsis
Get a list of shows saved in the current Spotify user's library.

### Syntax
Get-CurrentUserSavedShows [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserSavedShows

Grabs data of all saved shows and returns them in a list



---
## Get-CurrentUserSavedTracks

### Synopsis
Get a list of the songs saved in the current Spotify user's 'Your Music' library.

### Syntax
Get-CurrentUserSavedTracks [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserSavedTracks

Grabs data of all saved tracks and returns them in a list



---
## Get-CurrentUserTopArtists

### Synopsis
Get the current user's top artists based on calculated affinity.

### Syntax
Get-CurrentUserTopArtists [[-TimeRange] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-TimeRange <String>
	    Long: calculated from several years of data and including all new data as it becomes available
	    Medium (default): approximately last 6 months
	    Short: approximately last 4 weeks

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserTopArtists -TimeRange Long

Gets top artists for user over several years



---
## Get-CurrentUserTopTracks

### Synopsis
Get the current user's top tracks based on calculated affinity.

### Syntax
Get-CurrentUserTopTracks [[-TimeRange] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-TimeRange <String>
	    Long: calculated from several years of data and including all new data as it becomes available
	    Medium (default): approximately last 6 months
	    Short: approximately last 4 weeks

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-CurrentUserTopTracks -TimeRange Long

Gets top tracks for user over several years



---
## Get-Episode

### Synopsis
Get Spotify catalog information for one or more episodes based on their Spotify IDs.

### Syntax
Get-Episode [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Episode Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Episode -Id 'blahblahblah'

Retrieves an episode from Spotify with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-Episode -Id 'blahblahblah','blahblahblah2'

Retrieves both specified episodes from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Get-Episode

Retrieves both specified episodes from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Get-FeaturedPlaylists

### Synopsis
Get a list of Spotify featured playlists (shown, for example, on a Spotify playerâ€™s â€˜Browseâ€™ tab).

### Syntax
Get-FeaturedPlaylists [[-Country] <String>] [[-Locale] <String>] [[-Timestamp] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Country <String>
	    Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
	    If omitted, the returned items will be relevant to all countries.
	    Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
	    Ex : FR

	-Locale <String>
	    Specifies the desired language
	    Uses an "ISO 639-1" language code and an "ISO 3166-1 alpha-2" country code, joined by an underscore
	    Ex : es_MX    meaning Spanish (Mexico)

	-Timestamp <String>
	    Specifies the userâ€™s local time to get results tailored for that specific date and time in the day.    
	    uses ISO 8601 format: yyyy-MM-ddTHH:mm:ss. 
	    Ex : 2014-10-23T09:00:00

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-FeaturedPlaylists

Retrieves all featured playlists



---
## Get-FollowedArtists

### Synopsis
Get the current userâ€™s followed artists.

### Syntax
Get-FollowedArtists [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-FollowedArtists

Grabs data of all followed artist and returns them in a list



---
## Get-NewReleases

### Synopsis
Get a list of new album releases featured in Spotify (shown, for example, on a Spotify playerâ€™s â€œBrowseâ€ tab).

### Syntax
Get-NewReleases [[-Country] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Country <String>
	    Specifies the country if you want to narrow the list of returned categories to those relevant to a particular country
	    If omitted, the returned items will be relevant to all countries.
	    Uses "ISO 3166-1 alpha-2" country code : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
	    Ex : FR

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-NewReleases

Retrieves all new releases



---
## Get-Playlist

### Synopsis
Get a playlist owned by a Spotify user.

### Syntax
Get-Playlist [-Id] <String> [[-Fields] <String>] [[-Market] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the playlist Id

	-Fields <String>
	    Filters for the query: a comma-separated list of the fields to return. If omitted, all fields are returned.
	    For example, to get just the playlistâ€™s description and URI: 'description,uri'.
	    A dot separator can be used to specify non-reoccurring fields, while parentheses can be used to specify reoccurring fields within objects.
	    For example, to get just the added date and user ID of the adder: 'tracks.items(added_at,added_by.id)'.
	    Use multiple parentheses to drill down into nested objects.
	    For example: 'tracks.items(track(name,href,album(name,href)))'.
	    Fields can be excluded by prefixing them with an exclamation mark.
	    For example: 'tracks.items(track(name,href,album(!name,href)))'

	-Market <String>
	    Specifies an ISO 3166-1 alpha-2 country code or the string from_token.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Playlist -Id 'blahblahblah'

Retrieves a playlist with the Id of 'blahblahblah'



---
## Get-PlaylistCoverImage

### Synopsis
Get the current image associated with a specific playlist.

### Syntax
Get-PlaylistCoverImage [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify ID for the playlist.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-PlaylistCoverImage -Id 'thisPlaylistId'

Grabs image information of playlists with Id 'thisPlaylistId'



---
## Get-PlaylistItems

### Synopsis
Get a playlist owned by a Spotify user.

### Syntax
Get-PlaylistItems [-Id] <String> [[-Field] <String>] [[-Market] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify ID for the playlist.

	-Field <String>
	    Filters for the query: a comma-separated list of the fields to return. If omitted, all fields are returned.
	    For example, to get just the total number of items and the request limit: 'total,limit'
	    A dot separator can be used to specify non-reoccurring fields, while parentheses can be used to specify reoccurring fields within objects.
	    For example, to get just the added date and user ID of the adder: 'items(added_at,added_by.id)'.
	    Use multiple parentheses to drill down into nested objects.
	    For example: 'items(track(name,href,album(name,href)))'.
	    Fields can be excluded by prefixing them with an exclamation mark.
	    For example: 'items.track.album(!external_urls,images)'

	-Market <String>
	    Specifies an ISO 3166-1 alpha-2 country code or the string from_token.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-PlaylistItems -Id 'blahblahblah'

Retrieves tracks or episodes of the playlist with the Id of 'blahblahblah'



---
## Get-RecentlyPlayedTracks

### Synopsis
Get tracks from the current user's recently played tracks.

### Syntax
Get-RecentlyPlayedTracks [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-RecentlyPlayed

Retrieves the recently played tracks



---
## Get-RecommendationGenres

### Synopsis
Retrieve a list of available genres seed parameter values for recommendations.

### Syntax
Get-RecommendationGenres [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-RecommendationGenres

Retrieves all recommendation genres from Spotify



---
## Get-Recommendations

### Synopsis
Create a playlist-style listening experience based on seed artists, tracks and genres.

### Syntax
Get-Recommendations [[-SeedArtists] <Array>] [[-SeedGenres] <Array>] [[-SeedTracks] <Array>] [[-OtherFilters] <Array>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description
Recommendations are generated based on the available information for a given seed entity and matched against similar artists and tracks.
If there is sufficient information about the provided seeds, a list of tracks will be returned together with pool size details.

### Parameters

	-SeedArtists <Array>
	    Specifies a comma separated list of spotify Ids for artists.
	    Up to 5 seed values may be provided in any combination of SeedArtists, SeedTracks and SeedGenres.

	-SeedGenres <Array>
	    Specifies a comma separated list of any genres in the set of available genre seeds.
	    Up to 5 seed values may be provided in any combination of SeedArtists, SeedTracks and SeedGenres.

	-SeedTracks <Array>
	    Specifies a comma separated list of Spotify IDs for a seed track.
	    Up to 5 seed values may be provided in any combination of SeedArtists, SeedTracks and SeedGenres.

	-OtherFilters <Array>
	    Specifies a list of additional query parameters in min_*, max_* and target_* list (https://developer.spotify.com/documentation/web-api/reference/browse/get-recommendations/)
	    Ex : @('min_acousticness=1.0','max_energy=1.0','min_popularity=50')

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Recommendations -SeedArtists @('artist1', 'artist2') -SeedGenres @('genre1') -SeedTracks @('track1')

Retrieves recommendations based on all provided attributes



---
## Get-Show

### Synopsis
Gets one or more shows.

### Syntax
Get-Show [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Show Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Show -Id 'blahblahblah'

Retrieves a show from Spotify with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-Show -Id 'blahblahblah','blahblahblah2'

Retrieves both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Get-Show

Retrieves both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Get-ShowEpisodes

### Synopsis
Get Spotify catalog information about a show's episodes. Optional parameters can be used to limit the number of episodes returned.

### Syntax
Get-ShowEpisodes [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Show Id

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-ShowEpisodes -Id 'blahblahblah'

Retrieves show episodes from spotify show with the Id of "blahblahblah"



---
## Get-SpotifyApplication

### Synopsis
Retrieves saved spotify credential

### Syntax
Get-SpotifyApplication [[-Name] <String>] [-All] [<CommonParameters>]

### Description
Finds saved spotify credential on local machine if there is one.

### Parameters

	-Name <String>
	    Specifies the name of the spotify application you're looking for

	-All <SwitchParameter>
	    Specifies that you're looking for all Spotify Application in store

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-SpotifyApplication

Looks for a saved spotify application file of the name 'default'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-SpotifyApplication -Name 'dev'

Looks for a saved spotify application file of the name 'dev'



---
## Get-Track

### Synopsis
Get Spotify catalog information for one or more tracks based on their Spotify IDs.

### Syntax
Get-Track [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Track Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-Track -Id 'blahblahblah'

Retrieves an track from Spotify with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-Track -Id 'blahblahblah','blahblahblah2'

Retrieves both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Get-Track

Retrieves both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Get-TrackAudioAnalysis

### Synopsis
Get a detailed audio analysis for a single track identified by its unique Spotify ID.

### Syntax
Get-TrackAudioAnalysis [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The Spotify ID for the track.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-TrackAudioAnalysis -Id 'blahblahblah'

Retrieves audio analysis for a track from spotify with the Id of 'blahblahblah'



---
## Get-TrackAudioFeature

### Synopsis
Get audio features for one or more tracks based on their Spotify IDs.

### Syntax
Get-TrackAudioFeature [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Track Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-TrackAudioFeature -Id 'blahblahblah'

Retrieves audio features for track from Spotify with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Get-TrackAudioFeature -Id 'blahblahblah','blahblahblah2'

Retrieves audio features for both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Get-TrackAudioFeature

Retrieves audio features for both specified tracks from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Get-UserPlaylists

### Synopsis
Get a list of the playlists owned or followed by a Spotify user.

### Syntax
Get-UserPlaylists [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify user we want to search for

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-UserPlaylists -Id 'thisUserId'

Grabs data of playlists of user with Id 'thisUserId'



---
## Get-UserProfile

### Synopsis
Get public profile information about a Spotify user.

### Syntax
Get-UserProfile [[-UserId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-UserId <String>
	    Specifies the spotify user we want to search for

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Get-UserProfile 'myusername'

Gets the public user profile information about myusername



---
## Invoke-NextTrack

### Synopsis
Skips to next track in the user's queue.

### Syntax
Invoke-NextTrack [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Invoke-NextTrack

Skips to next track



---
## Invoke-PreviousTrack

### Synopsis
Skips to previous track in the user's queue.

### Syntax
Invoke-PreviousTrack [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description
Note that this will always skip to the previous track, regardless of the current trackâ€™s progress.

### Parameters

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Invoke-PreviousTrack

Skips to previous track



---
## Invoke-SeekPositionCurrentTrack

### Synopsis
Seeks to the given position in the user's currently playing track.

### Syntax
Invoke-SeekPositionCurrentTrack [-PositionMs] <Int32> [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-PositionMs <Int32>
	    The position in milliseconds to seek to. 
	    Must be a positive number.
	    Passing in a position that is greater than the length of the track will cause the player to start playing the next song.

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Invoke-SeekPositionCurrentTrack -PositionMs 120000

Seeks current track to position 2:00



---
## Invoke-SpotishellLogo

### Synopsis
Display a ascii spotishell logo on screen.

### Syntax
Invoke-SpotishellLogo [<CommonParameters>]

### Description


### Parameters

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Invoke-Ascii

Display a ascii spotishell logo on screen.



---
## Move-Playback

### Synopsis
Transfer playback to a new device and determine if it should start playing.

### Syntax
Move-Playback [-DeviceId] <String> [[-Play] <Boolean>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-Play <Boolean>
	    Specifies if it should start playing.
	    $true: ensure playback happens on new device.
	    $false or not provided: keep the current playback state.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Move-Playback -DeviceId '6ea768bcdce0c0be68b0905d8afe500107abea70'

Transfer playback to the device with id '6ea768bcdce0c0be68b0905d8afe500107abea70'



---
## New-Playlist

### Synopsis
Create a playlist for a Spotify user. (The playlist will be empty until you add tracks.)

### Syntax
New-Playlist [-UserId] <String> [-Name] <String> [[-Public] <Boolean>] [[-Collaborative] <Boolean>] [[-Description] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-UserId <String>
	    Specifies the user's Spotify user ID.

	-Name <String>
	    The name for the new playlist
	    This name does not need to be unique; a user may have several playlists with the same name.

	-Public <Boolean>
	    $True the playlist will be public (default)
	    $False it will be private

	-Collaborative <Boolean>
	    $True the playlist will be collaborative.
	    $False the playlist will not be collaborative (default)
	    Note that to create a collaborative playlist you must also set Public to false .

	-Description <String>
	    Value for playlist description as displayed in Spotify Clients and in the Web API.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>New-Playlist -UserId (Get-CurrentUserProfile).id -Name 'New Playlist'

Create a new playlist named 'New Playlist'



---
## New-SpotifyApplication

### Synopsis
Creates a new application

### Syntax
New-SpotifyApplication [[-Name] <String>] [-ClientId] <String> [-ClientSecret] <String> [[-RedirectUri] <String>] [<CommonParameters>]

### Description
Creates a new application and saves it locally (file) so you may re-use it without setting it every time

### Parameters

	-Name <String>
	    Specifies the name of the application you want to save ('default' if not specified).

	-ClientId <String>
	    Specifies the Client ID of the Spotify Application

	-ClientSecret <String>
	    Specifies the Client Secret of the Spotify Application

	-RedirectUri <String>
	    Specifies the Redirect Uri of the Spotify Application

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>New-SpotifyApplication -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'

Creates the default application json in the store, named default.json and containing default as Name, ClientId and ClientSecret.




-------------------------- EXAMPLE 2 --------------------------

PS C:\>New-SpotifyApplication -Name 'dev' -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'

Creates a new application json in the store, named dev.json and containing Name, ClientId and ClientSecret.



---
## Remove-CurrentUserSavedAlbum

### Synopsis
Remove one or more albums from the current user's 'Your Music' library.

### Syntax
Remove-CurrentUserSavedAlbum [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify album Ids that you want to remove

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-CurrentUserSavedAlbum -Id 'blahblahblah'

Remove the saved album with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-CurrentUserSavedAlbum -Id 'blahblahblah','blahblahblah2'

Remove both saved albums with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Remove-CurrentUserSavedAlbum

Remove both saved albums with the Id of 'blahblahblah' for the user authed under the current Application



---
## Remove-CurrentUserSavedShow

### Synopsis
Delete one or more shows from current Spotify user's library.

### Syntax
Remove-CurrentUserSavedShow [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify show Ids that you want to remove

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-CurrentUserSavedShow -Id 'blahblahblah'

Remove the saved show with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-CurrentUserSavedShow -Id 'blahblahblah','blahblahblah2'

Remove both saved shows with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Remove-CurrentUserSavedShow

Remove both saved shows with the Id of 'blahblahblah' for the user authed under the current Application



---
## Remove-CurrentUserSavedTrack

### Synopsis
Remove one or more tracks from the current user's 'Your Music' library.

### Syntax
Remove-CurrentUserSavedTrack [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify track Ids that you want to remove

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-CurrentUserSavedTrack -Id 'blahblahblah'

Remove the saved track with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-CurrentUserSavedTrack -Id 'blahblahblah','blahblahblah2'

Remove both saved tracks with the Id of 'blahblahblah' for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Remove-CurrentUserSavedTrack

Remove both saved tracks with the Id of 'blahblahblah' for the user authed under the current Application



---
## Remove-FollowedArtist

### Synopsis
Remove the current user as a follower of one or more artists.

### Syntax
Remove-FollowedArtist [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify artist Ids that you want to unfollow

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-FollowedArtist -Id 'blahblahblah'

Remove the artist with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-FollowedArtist -Id 'blahblahblah','blahblahblah2'

Remove both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Remove-FollowedArtist

Remove both artists with the Id of 'blahblahblah' to follow for the user authed under the current Application



---
## Remove-FollowedPlaylist

### Synopsis
Remove the current user as a follower of a playlist.

### Syntax
Remove-FollowedPlaylist [-Id] <String> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The spotify Id of the playlist we want to unfollow

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-FollowedPlaylist -Id 'blahblahblah'

Remove the playlist with the Id of 'blahblahblah' to follow for the user authed under the current application



---
## Remove-FollowedUser

### Synopsis
Remove the current user as a follower of one or more other Spotify users.

### Syntax
Remove-FollowedUser [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Spotify user Ids that you want to unfollow

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-FollowedUser -Id 'blahblahblah'

Remove the user with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-FollowedUser -Id 'blahblahblah','blahblahblah2'

Remove both users with the Id of 'blahblahblah' to follow for the user authed under the current Application




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Remove-FollowedUser

Remove both users with the Id of 'blahblahblah' to follow for the user authed under the current Application



---
## Remove-PlaylistItems

### Synopsis
Remove one or more items from a user's playlist.

### Syntax
Remove-PlaylistItems [-Id] <String> [-Track] <Array> [[-SnapshotId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify ID for the playlist.

	-Track <Array>
	    An array of objects containing Spotify URIs of the tracks and episodes to remove
	    It may contains specific positions of each tracks/episodes to remove (zero-indexed)

	-SnapshotId <String>
	    The playlist's snapshot ID against which you want to make the changes.
	    The API will validate that the specified items exist and in the specified positions and make the changes, even if more recent changes have been made to the playlist.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-PlaylistItems -Id 'myPlaylistId' -Track @(@{uri = 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh' }, @{uri = 'spotify:track:1301WleyT98MSxVHPZCA6M' })

Removes all occurrences of both tracks by specifying only uris in playlist with Id 'myPlaylistId'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-PlaylistItems -Id 'myPlaylistId' -Track @(@{uri = 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh'; positions = @(0, 3) }, @{uri = 'spotify:track:1301WleyT98MSxVHPZCA6M' ; 
positions = @(7) })

Removes specific occurrence of both tracks by specifying both the uris and items positions in the playlist with Id 'myPlaylistId'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>Remove-PlaylistItems -Id 'myPlaylistId' -Track @(@{uri = 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh' }) -SnapshotId 'mySuperPlaylistSnapshot'

Removes all occurrences of both tracks in the specific snapshot with Id 'mySuperPlaylistSnapshot' of the playlist



---
## Remove-SpotifyApplication

### Synopsis
Removes saved spotify credential

### Syntax
Remove-SpotifyApplication [[-Name] <String>] [<CommonParameters>]

### Description
Removes saved spotify credential on local machine if there is one.

### Parameters

	-Name <String>
	    Specifies the name of the spotify application you want to remove

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Remove-SpotifyApplication

Remove a saved spotify application file of the name 'default'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Remove-SpotifyApplication -Name 'dev'

Remove a saved spotify application file of the name 'dev'



---
## Restore-Library

### Synopsis
Restore Library items from json file (Playlists, FollowedArtists, SavedAlbums, SavedShows, SavedTracks)

### Syntax
Restore-Library [-Path] <String> [[-Type] <Array>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Path <String>
	    Path of the backup file you want to restore

	-Type <Array>
	    One or more items type to restore (All, FollowedArtists, SavedAlbums, SavedShows, SavedTracks)

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Restore-Library -Path $FilePath

Restore all Library items from '.\mySpotifyBackup.json'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Restore-Library -Type FollowedArtists,SavedAlbums -Path $FilePath

Restore Followed Artists and Saved Albums items from '.\mySpotifyBackup.json'



---
## Resume-Playback

### Synopsis
Resume current playback on the user's active device.

### Syntax
Resume-Playback [[-DeviceId] <Array>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-DeviceId <Array>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Resume-Playback

Resumes current playback on the user's active device



---
## Search-Item

### Synopsis
Get Spotify Catalog information about albums, artists, playlists, tracks, shows or episodes that match a keyword string.

### Syntax
Search-Item [-Query] <String> [-Type] <Array> [[-Market] <String>] [-IncludeExternalAudio] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Query <String>
	    Specifies the Search query keywords and optional field filters and operators.
	    Keyword matching: Matching of search keywords is not case-sensitive. Operators, however, should be specified in uppercase.
	        Unless surrounded by double quotation marks, keywords are matched in any order.
	    Operator: The operator NOT can be used to exclude results.
	        the OR operator can be used to broaden the search
	    Field filters: By default, results are returned when a match is found in any field of the target object type.
	        Searches can be made more specific by specifying an album, artist or track field filter.
	    To limit the results to a particular year, use the field filter year with album, artist, and track searches.
	    To retrieve only albums released in the last two weeks, use the field filter tag:new in album searches
	    More details and exemple here : https://developer.spotify.com/documentation/web-api/reference/search/search/

	-Type <Array>
	    A list of item types to search across.
	    Valid types are: All, Album, Artist, Playlist, Track, Show and Episode

	-Market <String>
	    An ISO 3166-1 alpha-2 country code or the string from_token.
	    If a country code is specified, only artists, albums, and tracks with content that is playable in that market is returned.

	-IncludeExternalAudio <SwitchParameter>
	    Specifies to include any relevant audio content that is hosted externally in the response.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Search-Item -Query 'Adam Tell' -Type Artist

Will search for just artists containing both words 'Adam' and 'Tell'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Search-Item -Query 'Party' -Type All

Will search for anything named 'Party'.



---
## Send-PlaylistCoverImage

### Synopsis
Replace the image used to represent a specific playlist.

### Syntax
Send-PlaylistCoverImage -Id <String> -ImagePath <String> [-ApplicationName <String>] [<CommonParameters>]

Send-PlaylistCoverImage -Id <String> -ImageBase64 <String> [-ApplicationName <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify ID for the playlist.

	-ImagePath <String>
	    Path to a JPEG Image file to send.  (~190KB max size)

	-ImageBase64 <String>

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Send-PlaylistCoverImage -Id 'blahblahblah' -ImagePath '..\myCoverImage.jpg'

Set cover image of the playlist with id 'blahblahblah' using '..\myCoverImage.jpg'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Send-PlaylistCoverImage -Id 'blahblahblah' -ImageBase64 '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAcFBQYFBAcGBQYIBwcIChELCgkJChUPEAwRGBUaGRgVGBcbHichGx0lHRcYIi4iJSgpKywrGiAvMy8qM
icqKyr/2wBDAQcICAoJChQLCxQqHBgcKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKir/wgARCAAWABUDAREAAhEBAxEB/8QAFgAAAwAAAAAAAAAAAAAAAAAABQYH/8QAFwEAAwEAAAAAAAAAAA
AAAAAAAwQFBv/aAAwDAQACEAMQAAAAqs1kRGdedTMmOcoikj0XSSzjIl0BXdwH/8QAKxAAAwACAQMBBgcBAAAAAAAAAQIDBAUGABESFAchMTJBURMiM0RhcXJz/9oACAEBAAE/AOX8zy8HPtq9PfEw/SSFtjs8v3zw1b5UVe4DUPx957K
On2XJtVeDQ5Uufe36WDtIQRMkjuxVGkiMp8f99uuO76HIdLLYxSkixadYOPzxojFXRu31DA9crhFM7mes2uM9/VVnm+Ckq1sZpSmXUqCx8DNwQAetdyzTck3+mGFAXyMQtTG8PUDxRkKM5LxVewVvq3XsyQvp9tsf2uy2lb4v8zCJLy/p
mmzDrkPGddyGEPXissiD98fLxn/DtEn4+LfY/UHuD1D2W4Iuw2e52WfjV+fFIhBLf9DGaM/WNOMIiMJrOcgEVFUBVA+AA+3X/8QAIREAAgEEAgIDAAAAAAAAAAAAAQIDAAQRMQUhEhQiUWH/2gAIAQIBAT8Au731/jjyJ0Kg5ltlOhv8q
FxIgYVyCP7KMpx9GpuPFrbuFbJOM1YQskChqlgjl2KWwhHeKHVf/8QAHREAAgIDAAMAAAAAAAAAAAAAAQIAAwQRIRATIv/aAAgBAwEBPwCmj277Dgrodjpo6mK4CnkFhcjktP1EciG5vH//2Q=='

Set a smiley cover image on the playlist with id 'blahblahblah'



---
## Set-PlaybackVolume

### Synopsis
Set the volume for the user's current playback device.

### Syntax
Set-PlaybackVolume [-VolumePercent] <Int32> [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-VolumePercent <Int32>
	    The volume to set. (0-100)

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Set-PlaybackVolume -VolumePercent 70

Sets playback volume to 70



---
## Set-Playlist

### Synopsis
Change a playlist's name and public/private state. (The user must, of course, own the playlist.)

### Syntax
Set-Playlist [-Id] <String> [[-Name] <String>] [[-Public] <Boolean>] [[-Collaborative] <Boolean>] [[-Description] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    The Spotify ID for the playlist.

	-Name <String>
	    Specifies the new name for the playlist

	-Public <Boolean>
	    $True the playlist will be public
	    $False it will be private

	-Collaborative <Boolean>
	    $True the playlist will become collaborative and other users will be able to modify the playlist in their Spotify client.
	    Note: You can only set collaborative to true on non-public playlists.

	-Description <String>
	    Value for playlist description as displayed in Spotify Clients and in the Web API.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Set-Playlist -Id 'myplaylistId' -Name 'New Playlist Name'

Change the name of the playlist with Id 'myplaylistId'



---
## Set-PlaylistItems

### Synopsis
Replace all the items in a playlist, overwriting its existing items.

### Syntax
Set-PlaylistItems [-Id] <String> [[-Uris] <Array>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <String>
	    Specifies the Spotify ID for the playlist.

	-Uris <Array>
	    Specifies an array of the Spotify URIs to set, can be track or episode URIs.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Set-PlaylistItems -Id 'blahblahblah'

Empties the playlist with id 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Set-PlaylistItems -Id 'blahblahblah' -Uris @('spotify:track:4iV5W9uYEdYUVa79Axb7Rh','spotify:track:1301WleyT98MSxVHPZCA6M')

Put both uris in the playlist with id 'blahblahblah' (previous content of the playlist is lost)



---
## Set-RepeatMode

### Synopsis
Set the repeat mode for the user's playback. Options are repeat-track, repeat-context, and off.

### Syntax
Set-RepeatMode [-State] <String> [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-State <String>
	    Specifies the repeat mode to set
	    Track will repeat the current track.
	    Context will repeat the current context.
	    Off will turn repeat off.

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Set-RepeatMode -State Track

Set Repeat mode on current track



---
## Set-ShufflePlayback

### Synopsis
Toggle shuffle on or off for user's playback.

### Syntax
Set-ShufflePlayback [-State] <Boolean> [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-State <Boolean>
	    Specifies the shuffle mode to set
	    $true : Shuffle user's playback
	    $false : Do not shuffle user's playback.

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Set-ShufflePlayback -State $true

Set Shuffle mode ON



---
## Set-SpotifyApplication

### Synopsis
Modifies an aplication credentials

### Syntax
Set-SpotifyApplication [-Name <String>] -ClientId <String> -ClientSecret <String> [-RedirectUri <String>] [<CommonParameters>]

Set-SpotifyApplication [-Name <String>] -Token <Object> [<CommonParameters>]

### Description
Allows to modify clientId and ClientSecret of an existing Spotify application credentials

### Parameters

	-Name <String>
	    Specifies the name of the application credentials you want to modify ('default' if not specified).

	-ClientId <String>
	    Specifies the new Client ID of the Spotify Application

	-ClientSecret <String>
	    Specifies the new Client Secret of the Spotify Application

	-RedirectUri <String>
	    Specifies the new redirect Uri of the Spotify Application

	-Token <Object>
	    Specifies the new Token retrieved from the Spotify Application

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Set-SpotifyApplication -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'

Change the content of the default application credentials json in the store (named default.json) using new ClientId and ClientSecret provided.




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Set-SpotifyApplication -Name 'dev' -ClientId 'ClientIdOfSpotifyApplication' -ClientSecret 'ClientSecretOfSpotifyApplication'

Change the content of the application credentials json named dev.json using new ClientId and ClientSecret provided.



---
## Start-Playback

### Synopsis
Start a new context on the user's active device.

### Syntax
Start-Playback [-DeviceId <String>] [-ContextUri <String>] -TrackUris <Array> [-OffsetPosition <Int32>] [-OffsetUri <String>] [-PositionMs <Int32>] [-ApplicationName <String>] 
[<CommonParameters>]

Start-Playback [-DeviceId <String>] -ContextUri <String> [-TrackUris <Array>] [-OffsetPosition <Int32>] [-OffsetUri <String>] [-PositionMs <Int32>] [-ApplicationName <String>] 
[<CommonParameters>]

### Description


### Parameters

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ContextUri <String>
	    Specifies the Spotify URI of the context to play.
	    Valid contexts are albums, artists, playlists.

	-TrackUris <Array>
	    Specifies an array of track URIs to play

	-OffsetPosition <Int32>
	    Indicates from where in the context playback should start.
	    It's zero based.
	    Only available when ContextUri corresponds to an album or playlist object, or when the TrackUris parameter is used.

	-OffsetUri <String>
	    Indicates from where in the context playback should start.
	    It's representing the uri of the item to start at
	    Only available when ContextUri corresponds to an album or playlist object, or when the TrackUris parameter is used.

	-PositionMs <Int32>
	    Indicates from what position to start playback.
	    Passing in a position that is greater than the length of the track will cause the player to start playing the next song.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Start-Playback

Start playback



---
## Suspend-Playback

### Synopsis
Pause playback on the user's account.

### Syntax
Suspend-Playback [[-DeviceId] <String>] [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-DeviceId <String>
	    The id of the device this command is targeting.
	    If not supplied, the user's currently active device is the target.

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Suspend-Playback

Pauses playback



---
## Test-CurrentUserSavedAlbum

### Synopsis
Check if one or more albums is already saved in the current Spotify user's 'Your Music' library.

### Syntax
Test-CurrentUserSavedAlbum [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Album Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Test-CurrentUserSavedAlbum -Id 'blahblahblah'

Check to see if the current user saved the album with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Test-CurrentUserSavedAlbum -Id 'blahblahblah','blahblahblah2'

Check to see if the current user saved both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Test-CurrentUserSavedAlbum

Check to see if the current user saved both specified albums from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Test-CurrentUserSavedShow

### Synopsis
Check if one or more shows is already saved in the current Spotify user's library.

### Syntax
Test-CurrentUserSavedShow [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Show Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Test-CurrentUserSavedShow -Id 'blahblahblah'

Check to see if the current user saved the show with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Test-CurrentUserSavedShow -Id 'blahblahblah','blahblahblah2'

Check to see if the current user saved both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Test-CurrentUserSavedShow

Check to see if the current user saved both specified shows from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Test-FollowedArtist

### Synopsis
Check to see if the current user is following one or more artists.

### Syntax
Test-FollowedArtist [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more Artist Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Test-FollowedArtist -Id "blahblahblah"

Check to see if the current user follows the artist with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Test-FollowedArtist -Id 'blahblahblah','blahblahblah2'

Check to see if the current user follows both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Test-FollowedArtist

Check to see if the current user follows both specified artists from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---
## Test-FollowedPlaylist

### Synopsis
Check to see if one or more Spotify users are following a specified playlist.

### Syntax
Test-FollowedPlaylist [-PlaylistId] <String> [-UserId] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-PlaylistId <String>
	    The spotify Id of the playlist we want to check

	-UserId <Array>
	    One or more User Ids that may follow the playlist

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Test-FollowedPlaylist -PlaylistId 'blahblahblah' -UserId (Get-CurrentUserProfile).id

Check to see if the current user follows the playlist with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Test-FollowedPlaylist -PlaylistId 'blahblahblah' -UserId 'user1','user2'

Check to see if the users 'user1' and 'user2' follow the playlist with the Id of 'blahblahblah'



---
## Test-FollowedUser

### Synopsis
Check to see if the current user is following one or more other Spotify users.

### Syntax
Test-FollowedUser [-Id] <Array> [[-ApplicationName] <String>] [<CommonParameters>]

### Description


### Parameters

	-Id <Array>
	    One or more User Ids

	-ApplicationName <String>
	    Specifies the Spotify Application Name (otherwise default is used)

### Examples

-------------------------- EXAMPLE 1 --------------------------

PS C:\>Test-FollowedUser -Id "blahblahblah"

Check to see if the current user follows the user with the Id of 'blahblahblah'




-------------------------- EXAMPLE 2 --------------------------

PS C:\>Test-FollowedUser -Id 'blahblahblah','blahblahblah2'

Check to see if the current user follows both specified users from Spotify with Ids 'blahblahblah' and 'blahblahblah2'




-------------------------- EXAMPLE 3 --------------------------

PS C:\>@('blahblahblah','blahblahblah2') | Test-FollowedUser

Check to see if the current user follows both specified users from Spotify with Ids 'blahblahblah' and 'blahblahblah2'



---

*This combined documentation page was created using https://github.com/lesterw1/AzureExtensions/tree/master/Ax.Markdown cmdlet.*

