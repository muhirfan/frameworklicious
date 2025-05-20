# Live Activities Framework Overview

ActivityKit, introduced in iOS 16, provides simple APIs to start, update, and end Live Activities, managing their lifecycle without requiring manual background coding. Updates can be delivered locally from your app or remotely via APNs push notifications, so users always see fresh information. ActivityKit extensions use SwiftUI and WidgetKit’s `ActivityConfiguration` to declare minimal, compact, or expanded views for different display contexts.

---

## What Are Live Activities?

A Live Activity is a persistent, glanceable UI element representing an ongoing task or event with a clear start and end. They appear on multiple surfaces—**Lock Screen**, **Dynamic Island**, **StandBy**, and the **Apple Watch Smart Stack**—letting people monitor progress at a glance. Developers define `ActivityAttributes` for static data and `ContentState` for dynamic updates, which SwiftUI uses to render live information.

---

## Resources

### Official Documentation

- [ActivityKit API Reference](https://developer.apple.com/documentation/activitykit/)
- [Displaying live data with Live Activities](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities)
- [Starting and updating Live Activities with ActivityKit push notifications](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications)

### Human Interface Guidelines

- [Live Activities HIG](https://developer.apple.com/design/human-interface-guidelines/live-activities/)

### WWDC Videos

- [Meet ActivityKit (WWDC 2023)](https://developer.apple.com/videos/play/wwdc2023/10184/)
- [Design dynamic Live Activities (WWDC 2023)](https://developer.apple.com/videos/play/wwdc2023/10194/)
- [Update Live Activities with push notifications (WWDC 2023)](https://developer.apple.com/videos/play/wwdc2023/10185/)
- [Bring your Live Activity to Apple Watch (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10068/)
- [Design Live Activities for Apple Watch (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10098/)
- [Broadcast updates to your Live Activities (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10069/)
