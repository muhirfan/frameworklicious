#  App Intents Overview

**App Intents** is Apple’s unified framework for exposing your app’s features system-wide—via Siri, Shortcuts, Spotlight, Widgets, the Action button, and more.  
Instead of writing separate integrations (like SiriKit, widget APIs, Spotlight indexing), you declare **Intents** (actions) with **Parameters** (user inputs) once, and the OS handles discovery, input collection, and deep-linking automatically.

**Benefits:**
- Increased app discoverability
- Higher user engagement
- Enables non-technical users to automate workflows—no coding required

---

## How App Intents Actually Work (Non-Technical)

Think of **App Intents** like giving your app superpowers — so it can talk to Siri, show up in Spotlight search, or work with the Shortcuts app.

Here’s a real-world comparison to help you understand:

> Imagine your app is a restaurant.  
> App Intents are like putting items from your menu into a **universal food delivery app** (like DoorDash).  
> Now, customers (users) can:
> - Search for your dish (in Spotlight or Siri)
> - Ask Siri to "Order sushi from [Your App]"
> - Add it to a routine, like "When I get home, order dinner."

All you do as a developer is:
- 📋 Describe what your app can do (Intents)
- 🧑‍🍳 Explain what options the user can pick (Parameters)
- 🧭 Let Apple handle the rest (UI, voice, automation)

### So what happens when someone uses your shortcut?
1. The system finds your Intent (like "Change background color").
2. It asks the user for any needed info ("What color?").
3. It runs the logic you wrote.
4. (Optional) It can open your app to show the result.

This means **anyone**, even non-coders, can automate your app — just by using natural language or tapping a Shortcut!

---

---

##  How It Works

### 1. Define an Intent
Create a Swift struct that conforms to `AppIntent`, add a title, optional description, and implement the `perform()` method.

### 2. Declare Parameters
Use the `@Parameter` property wrapper to collect inputs like strings, dates, enums, or custom types.

### 3. Publish Shortcuts
Conform to `AppShortcutsProvider`, then define entries inside `@AppShortcutsBuilder` with:
- Example phrases
- `shortTitle`
- SF Symbol name

### 4. (Optional) Open App
Use:
```swift
static var openAppWhenRun: Bool = true
```

##  Low-Level Syntax

### Declaring an Intent

```swift
import AppIntents

@available(iOS 16.0, *)
struct MyActionIntent: AppIntent {
  static var title: LocalizedStringResource = "My Action"
  static var openAppWhenRun: Bool = true

  @Parameter(title: "Name")
  var name: String

  static var parameterSummary: some ParameterSummary {
    Summary("Do My Action with \(.$name)")
  }

  func perform() async throws -> some IntentResult {
    // your business logic here…
    return .result()
  }
}
```


## Providing Shortcuts

```
import AppIntents

@available(iOS 16.0, *)
struct IntentProvider: AppShortcutsProvider {
  @AppShortcutsBuilder
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: MyActionIntent(),
      phrases: [
        "Run My Action with name {Name}"
      ],
      shortTitle: "Do My Action",
      systemImageName: "bolt.fill"
    )
  }
}
```
 This makes My Action immediately discoverable in the Shortcuts app and Spotlight — no further setup required.

##  Examples

### 1. Change Color

- **Intent:** `ChangeColorIntent`
- **Parameter:** `ColorChoice` (AppEnum: red/green/blue)
- **openAppWhenRun:** `true`
- **Shortcut:** `"Change background color to green"`

 Common in App Intents tutorials.

---

### 2. Add a Timestamped Item

- **Intent:** `AddItemIntent(timestamp: Date)`
- **Dependency:** `@Dependency(key: "ModelContainer")`
- **Result:** Silent insertion into SwiftData container

Great for logging events or hands-free data capture.

---

##  Official Resources

- [App Intents Reference](https://developer.apple.com/documentation/appintents)
- [Intents (Core Concepts)](https://developer.apple.com/documentation/intents)

---

##  Human Interface Guidelines

Follow Apple's HIG for great voice + touch UX:

- [App Shortcuts HIG](https://developer.apple.com/design/human-interface-guidelines/app-shortcuts)
- [Design Great Actions (WWDC21)](https://developer.apple.com/videos/play/wwdc2021/10283)

---

##  Key WWDC Sessions

### WWDC 2022

- [Dive into App Intents](https://developer.apple.com/videos/play/wwdc2022/10032)
- [Implement App Shortcuts with App Intents](https://developer.apple.com/videos/play/wwdc2022/10170)
- [Design App Shortcuts](https://developer.apple.com/videos/play/wwdc2022/10169)

### WWDC 2024

- [What’s New in App Intents](https://developer.apple.com/videos/play/wwdc2024/10134)
- [Bring Your App’s Core Features to Users](https://developer.apple.com/videos/play/wwdc2024/10210)

---

# Star Walk 2 Plus – All-Sky Map (Found in App Store)

**Download**: [Star Walk 2 Plus on the App Store](https://apps.apple.com/us/app/star-walk-2-plus-all-sky-map/id1112481571?uo=2) – *Free*

<img width="300" alt="Screenshot 2025-05-08 at 1 58 52 PM" src="https://github.com/user-attachments/assets/1af66e12-ec8d-47e1-9de1-5e3eaeec548d" />

---

### Overview

Star Walk 2 Plus is an interactive astronomy guide that shows a real-time sky map aligned with your device’s orientation. Explore stars, constellations, planets, and celestial events as they happen. With 3D constellation models, satellite tracking, and eclipse alerts, it’s your all-in-one stargazing companion for iPhone and iPad. 

---

### App Intents (Siri Shortcuts) Integration

- **“Visible Tonight” Shortcut**: Create a Siri Shortcut from the Visible Tonight section to list astronomical events visible from your current location.
- **Hands-Free Stargazing**: Say “Hey Siri, show me tonight’s sky events” to open the app directly to current sky highlights—no manual navigation needed.
- **Deep-Link Context**: Launches into the Visible Tonight view while preserving your date and location settings.
- **Zero Configuration**: Powered by Apple’s App Intents framework—no setup beyond tapping “Add to Siri” is needed.

---

### Key Features

- **Interactive Sky Map**: Real-time star map synced with your device orientation—just point and explore.
- **3D Constellation Models**: Rotate and explore mythological constellations with legends and 3D effects.
- **Satellite & ISS Tracking**: Follow live orbits of satellites and the International Space Station with real-time pass alerts.
- **Night Mode & Date Travel**: Red-tinted night mode for dark-sky observing, and date scrolling for viewing past/future skies.
- **Educational Content**: Access articles on space exploration, celestial bodies, and astronomical discoveries—all within the app.
