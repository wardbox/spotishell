# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Spotishell is a PowerShell module for interacting with the Spotify Web API. It supports PowerShell 5.0+ and runs on Windows, macOS, and Linux. The module handles OAuth authentication, token refresh, and provides cmdlets for all Spotify API endpoints including playback control.

## Development Commands

```powershell
# Import module for local development
Import-Module ./Spotishell/Spotishell.psd1 -Force

# List available commands
Get-Command -Module Spotishell

# Get help for a specific cmdlet
Get-Help <CmdletName> -Full
```

## Architecture

### Module Structure
- `Spotishell/Spotishell.psm1` - Entry point that dot-sources all Public and Private functions and exports Public ones
- `Spotishell/Spotishell.psd1` - Module manifest with version and metadata
- `Spotishell/Public/` - Exported cmdlets organized by API category (Albums, Artists, Player, Playlists, etc.)
- `Spotishell/Private/` - Internal helper functions not exported to users

### Core Private Functions
- `Send-SpotifyCall.ps1` - Central API caller that handles all HTTP requests to Spotify, including rate limit handling (429 responses with retry-after)
- `Get-SpotifyAccessToken.ps1` - Implements OAuth Authorization Code Flow, handles token refresh, spawns local HTTP listener for OAuth callback
- `Get-StorePath.ps1` - Returns OS-appropriate credential storage path (`~/.spotishell/` on Unix, `%LOCALAPPDATA%\spotishell\` on Windows). Can be overridden via `SPOTISHELL_STORE_PATH` env var

### Authentication Flow
1. User creates app with `New-SpotifyApplication -ClientId <id> -ClientSecret <secret>`
2. Credentials stored as JSON in the store path
3. First API call triggers OAuth browser flow, tokens saved automatically
4. Token refresh handled transparently by `Get-SpotifyAccessToken`

### Cmdlet Patterns
- All cmdlets accept `-ApplicationName` to support multiple Spotify apps
- Most cmdlets support pipeline input for batch operations
- Functions follow PowerShell verb-noun naming (Get-, Set-, Add-, Remove-, Test-, Invoke-)

## Key Configuration

Default redirect URI: `http://127.0.0.1:8080/spotishell` (must be added to Spotify app settings)
