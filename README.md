<img src="https://i.imgur.com/plzJqJ0.png" height="72px">

# Spotishell

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg?style=for-the-badge&logo=appveyor)](https://www.paypal.me/wardbox/1)

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
New-SpotifyCredential -Name "appname" -ClientId "blahblahblah" -ClientSecret "blahblahblahblah"
```
5. Add "http://localhost:8080/spotifyapi" as a redirect URL in your Spotify app settings
[spotify developer Dashboard](https://developer.spotify.com/dashboard)

6. Give it a whirl!
```powershell
Search-Spotify -Query "Bloc Party" -Artist
```
7. Enjoy the bountiful data :^)

```
"Music is the silence between the notes"
  - Claude Debussy
```
