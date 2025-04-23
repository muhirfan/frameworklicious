#  App Intents Overview

**App Intents** is Apple’s unified framework for exposing your app’s features system-wide—via Siri, Shortcuts, Spotlight, Widgets, the Action button, and more.  
Instead of writing separate integrations (like SiriKit, widget APIs, Spotlight indexing), you declare **Intents** (actions) with **Parameters** (user inputs) once, and the OS handles discovery, input collection, and deep-linking automatically.

**Benefits:**
- Increased app discoverability
- Higher user engagement
- Enables non-technical users to automate workflows—no coding required

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

### 3. Movie Tracker (Advanced)

- **Entities:** `MovieItem` (conforms to `AppEntity`)
- **Enums:** `MovieRating` (AppEnum: “Good” / “Bad” / etc.)
- **Intent:** `MovieRatingIntent(MovieItem, MovieRating)`
- **Shortcuts:** Add Movie, Add Rating via `AppShortcutsProvider`

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

