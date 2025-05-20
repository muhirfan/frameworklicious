# GameKit Framework Overview

GameKit provides ready-to-use APIs for Game Center features, including player authentication, achievements, leaderboards, and multiplayer sessions. You don’t need to write server code—GameKit handles match setup, data delivery, and session management for you.

## Features

| Feature                | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| Achievements & Leaderboards | Let players earn badges and compare scores globally.                     |
| Matchmaking            | Auto-match or invite friends for real-time games using `GKMatchmaker`.     |
| Turn-Based Play        | Send “turn” data packets back and forth in games like chess or word puzzles.|
| Voice Chat             | Enable in-game voice conversation over Game Center sessions.                |
| Cross-Platform         | Works seamlessly across all major Apple platforms.                          |

---

## What is GameKit?

At its core, GameKit is a set of Swift/Objective-C classes you import into your project:

- `GKLocalPlayer`: Represents the signed-in player and handles authentication.
- `GKMatchmaker`: Finds or creates matches between players.
- `GKMatch` and `GKTurnBasedMatch`: Manage real-time and turn-based game data exchange.
- `GKLeaderboard`: Submit and query scores on leaderboards.
- `GKAchievement`: Create and report progress towards achievements.

To get started, enable the Game Center capability in your Xcode project's **Signing & Capabilities** pane and import GameKit. Then authenticate the local player and choose which features (leaderboards, matchmaking, etc.) to start.

---

## Resources

### Official Documentation

- [GameKit API Reference](https://developer.apple.com/documentation/gamekit/)
- [Enabling & Configuring Game Center](https://developer.apple.com/documentation/gamekit/enabling-and-configuring-game-center)

### Human Interface Guidelines

Game Center HIG: Best practices for designing interfaces around achievements, leaderboards, and multiplayer entry points  
[https://developer.apple.com/design/human-interface-guidelines/game-center/](https://developer.apple.com/design/human-interface-guidelines/game-center/)

### WWDC Videos

- [Design for Game Center (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10145/)
- [Tap into Game Center: Dashboard, Access Point, and Profile (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10618/)
- [Tap into Game Center: Leaderboards, Achievements, and Multiplayer (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10619/)
- [Reach New Players with Game Center Dashboard (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10064/)
- [What’s New in Game Center: Widgets, Friends, and Multiplayer Improvements (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10066/)
