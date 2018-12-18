. .\dev\CombinedFunctions\Combined.ps1

New-SpotifyCredential -Name "blah"
Set-SpotifyCredential -Name "dev" -Verbose
Remove-SpotifyCredential -Name "blah" -Verbose

#find an artist
$Artist = "Adam Tell"
$ArtistObject = Search-Spotify -Query $Artist -Artist

#find a song by that artist
$Song = "Foreground"

#find an album by that artist
$Album = "Recomposure"

#find song length of song by that artist
