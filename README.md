# FlowiOS starter (v0.2)

A native SwiftUI starter for an iOS media app inspired by the feature ideas of Flow.
This is an independently written starter, not a port of the Android Kotlin source.

## Build in GitHub Actions (no Mac required locally)
1. Upload the **contents** of this folder to the root of your GitHub repository.
2. Open the repository's **Actions** tab.
3. If prompted, enable GitHub Actions.
4. Select **Build iOS App** and choose **Run workflow**.
5. Download the `FlowiOS-Simulator-App` artifact after the run succeeds.

The workflow builds for the iOS Simulator. It does not create a signed IPA for installing on a physical iPhone.

## Current starter features
- SwiftUI tab navigation: Home, Search, Library, Settings
- Sample media feed and local search
- AVPlayer integration point for a media URL you are authorized to use
- Saved items and watch history stored locally
- Basic settings screen

## Not implemented yet
Live YouTube integration, accounts, recommendations, Shorts, SponsorBlock, downloads,
playlists, production backend, picture-in-picture and background audio are not complete.
Do not treat this starter as a finished app.

## Requirements
Xcode 16 or later is recommended. GitHub Actions uses a macOS runner with Xcode.
