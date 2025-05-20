# Shortcuts Framework Overview

The **Shortcuts** framework allows you to expose your app’s features as **actions** that users can combine and run in Apple's **Shortcuts app** or via **Siri**, enabling powerful automations without the need for any programming by the user.

- With **App Intents** (part of the framework), you define small, Swift-based "intents" representing individual tasks (e.g., adding or fetching items).
- App Intents removes the complexity of older Objective-C APIs (like SiriKit) and integrates smoothly into modern Swift and Xcode projects.
- Apple's **Human Interface Guidelines** offer best practices for designing intuitive, native-feeling Shortcut actions across iOS, iPadOS, and macOS.
- For the latest enhancements, such as deeper Siri and Spotlight integration, check out WWDC 2024’s “What’s New in App Intents” session.

---

## What Is Shortcuts?

**Shortcuts** is an app on iPhone and iPad that enables users to string together steps from different apps to automate everyday tasks—**no coding required**.

- Users can browse built-in actions, add your app’s custom actions, and run shortcuts by voice with **Siri**.
- Under the hood, every action you expose is defined by an **App Intent**, which specifies its:
  - Name
  - Parameters
  - Execution behavior
- Properly designed shortcuts appear system-wide, including:
  - In the **Shortcuts** app
  - Through **Siri suggestions**
  - Within **Spotlight search**

---

## Useful Links

### Official Documentation

- [Shortcuts for Developers](https://developer.apple.com/shortcuts/)  
  Learn how to integrate your app with the Shortcuts framework.

- [App Shortcuts Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-shortcuts/)  
  Best practices for surfacing app features and designing shortcut actions.

### WWDC Sessions

- [Dive into App Intents (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10032/)
- [Implement App Shortcuts with App Intents (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10170/)
- [What’s New in App Intents (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10134/)

---

## About This Simple Sample  App

This project is a simple **Task Manager** that demonstrates:

- **Adding tasks** via the app UI or the "Add Task" Shortcut action.
- **Listing tasks** in the app (auto-refreshing) or using a "Get Tasks" Shortcut action.
- **Clearing tasks** via an in-app button or the "Clear Tasks" Shortcut.

### Under the Hood:

- Each action is implemented as an **App Intent** that interacts with `UserDefaults.standard`.
- An `AppShortcutsProvider` bundles these intents, making them automatically discoverable inside the **Shortcuts app**.

---

# Shortcuts Sample App - Overcast (Found in App Store)

**Download**: [Overcast on the App Store](https://apps.apple.com/us/app/overcast/id888422857?uo=2) – *Free*

<img width="300" alt="Screenshot 2025-05-07 at 4 03 01 PM" src="https://github.com/user-attachments/assets/c0bee397-3d55-4d0f-b4a7-0cbe514df384" />

---

### Overview

Overcast is a powerful, award-winning podcast player for iPhone, iPad, Apple Watch, and Mac. It offers advanced audio features—like Smart Speed® and Voice Boost®—while maintaining a clean, intuitive interface for discovering, subscribing to, and listening to podcasts on the go.

---

### Shortcuts Integration

- **Built-in App Intents**: Supports “Play Podcast,” “Pause/Resume,” and “Open Playlist” as App Intents for automatic use in Shortcuts and Siri Suggestions.
- **Siri Voice Control**: Trigger playback with voice commands like “Hey Siri, play Overcast” or “Hey Siri, play my Favorites playlist in Overcast.”
- **Spotlight & Home Screen**: Shortcut actions appear in Spotlight and support one-tap Home Screen widgets.
- **Parameter Support**: Actions accept input like podcast name, playlist ID, or episode URL for dynamic automation workflows.

---

### Key Features

- **Smart Speed®**: Automatically shortens silences to save time without affecting audio quality.
- **Voice Boost®**: Equalizes volume across episodes for clearer, more consistent playback.
- **Custom Playlists**: Build and reorder playlists with smart filters like “Newest Unplayed” or “Favorites.”
