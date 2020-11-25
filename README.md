<img src="https://i.imgur.com/plzJqJ0.png" height="72px">

# Spotishell

### A powershell module used to interact with the Spotify API.

**This is a work in progress, as such, some portions may not be production quality or work at all.**
## Prerequisites
* [A spotify developer account and a registered app](https://developer.spotify.com/documentation/web-api/quick-start/)
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
5. Add "http://localhost:8080/spotishell" as a redirect URL in your Spotify app settings
[spotify developer Dashboard](https://developer.spotify.com/dashboard)

6. Give it a whirl!
```powershell
Search-Item -Query 'Bloc Party' -Type Artist
```
7. Enjoy the bountiful data :^)

```
"Music is the silence between the notes"
  - Claude Debussy
```

## Help
See [HELP](https://github.com/wardbox/spotishell/blob/master/HELP.md) for
the synopsis, syntax, and parameters for each of the cmdlets. 


If you feel so inclined, [buy me a coffee](https://www.buymeacoffee.com/wardbox)