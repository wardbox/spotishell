# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2025-12-02

### Fixed

- `Add-PlaylistItem` now correctly handles URI format (no longer requires `spotify:track:` prefix)
- `Add-PlaylistItem` `Position` parameter now works correctly with batch operations
- `Get-RecentlyPlayedTracks` now includes `context` field in response

### Added

- Episode support in `Get-RecentlyPlayedTracks`
- Batching support in `Add-PlaylistItem` for adding more than 100 items

## [1.2.0] - 2025-12-01

### Added

- PKCE (Proof Key for Code Exchange) support for OAuth authentication
- GitHub Actions CI/CD pipeline with multi-platform testing (Windows, macOS, Linux)
- PSScriptAnalyzer linting in CI
- Pester unit tests for core functionality
- Integration tests (credential-gated)

### Changed

- Replaced AppVeyor CI with GitHub Actions
- Improved OAuth security with PKCE code verifier/challenge

### Fixed

- Module import validation in CI pipeline

## [1.1.1] - 2023-05-01

### Fixed

- `Set-ShufflePlayback` boolean parameter handling (string conversion)
- Emoji handling in playlist names and descriptions
- Library backup/restore functionality
- Playlist image backup and restore
- UTF-8 encoding for library backup files

## [1.1.0] - 2023-04-01

### Added

- Arguments for `Get-RecentlyPlayedTracks` (limit, before, after parameters)
- `Test-UserSavedTrack` cmdlet (renamed from internal function)

### Changed

- Default redirect URL changed from `localhost` to `127.0.0.1` (Spotify requirement)

### Fixed

- `Get-ArtistAlbums` parameter handling
- `Set-PlaylistItems` now correctly handles >100 tracks (uses proper PUT semantics)

## [1.0.0] - 2020-10-01

### Added

- OAuth Authorization Code Flow with automatic token refresh
- HTTP listener for OAuth callback (no manual code entry)
- Support for multiple Spotify applications via `-ApplicationName` parameter
- Cross-platform support (Windows, macOS, Linux)

### Changed

- Made `UserName` parameter optional with sensible defaults
- Improved `Initialize-SpotifyApplication` result handling

## [0.1.7-alpha] - 2019-01-05

### Added

- Initial public release to PowerShell Gallery
- Core Spotify API endpoints for albums, artists, playlists, tracks, and playback
- Credential management and storage
- Search functionality
- User profile operations
