
# Spotishell
### A powershell module used to interact with the Spotify API.

**This is a work in progress, as such, some portions may not be production quality or work at all.**

---

## Prerequisites
* [A spotify developer account and a registered app](https://developer.spotify.com/documentation/web-api/quick-start/)
* PowerShell 5.0 or later (works on Mac and Linux too!)
* A cup of coffee or a nice tea

## Setup
1. Install from PSGallery
```powershell
Install-Module Spotishell
```

##### You may also clone from GitHub, if you want to do this I presume you know how :^)

2. Import module
```powershell
Import-Module Spotishell
```
3. List commands available in the module.  Familiarize yourself with these.
```powershell
Get-Command -Module Spotishell
```
##### 4. Sip drink of choice (optional)
##### 5. Take a breath (required!)
##### 6. Alright, let's continue (optional)
7. Set up your credential (use keys from your registered app referenced in the prerequisites
```powershell
New-SpotifyCredential -Name "appname" -ClientId "blahblahblah" -ClientSecret "blahblahblahblah"
```
8. Give it a whirl!
```powershell
Search-Spotify -Query "Bloc Party" -Artist
```
9. Enjoy the bountiful data :^)
---
```
"Music is the silence between the notes"
  - Claude Debussy
```
