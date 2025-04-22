<img src="https://i.imgur.com/plzJqJ0.png" height="72px">

# Spotishell

### A powershell module used to interact with the Spotify API.

It handles all Spotify Web API endpoints including control of players (https://developer.spotify.com/documentation/web-api/reference/)
## Prerequisites
* [A spotify premium account and a registered app](https://developer.spotify.com/documentation/web-api/quick-start/)
* PowerShell 5.0 or later
* A cup of coffee or a nice tea

## Setup
1. Install from PSGallery
```powershell
Install-Module Spotishell
```

2. Import module
```powershell
Import-Module Spotishell
```
3. List commands available in the module.  Familiarize yourself with these.
```powershell
Get-Command -Module Spotishell
```
4. Set up your credential (use keys from your registered app referenced in the prerequisites)
```powershell
New-SpotifyApplication -ClientId "blahblahblah" -ClientSecret "blahblahblahblah"
```
5. Add "http://127.0.0.1:8080/spotishell" as a redirect URL in your Spotify app settings
[spotify developer Dashboard](https://developer.spotify.com/dashboard)

6. Give it a whirl!
```powershell
Start-Playback -TrackUris @('spotify:track:4juzduULFJiZVIcrC1tkxE') # Start Banquet of Bloc Party on the first available device
Search-Item -Query 'Bloc Party' -Type Artist # look for Bloc Party artist
```
7. Enjoy the music and bountiful data :^)

```
"Music is the silence between the notes"
  - Claude Debussy
```

## Help
See [HELP](https://github.com/wardbox/spotishell/blob/master/HELP.md) for
the synopsis, syntax, and parameters for each of the cmdlets. 


If you feel so inclined, [buy me a coffee](https://www.buymeacoffee.com/wardbox)