# App Clips Overview

**App Clips** let users access a small part of your app—like ordering a coffee or paying for parking—**without installing the full app**.  
They are tiny (under 10 MB), launch almost instantly, and focus on a single, fast task.

This makes App Clips perfect for **on-the-go actions** with a smooth path into your full app if users want more.

---

## What Is an App Clip?

An **App Clip** is like a mini version of your app. It lets users:
- Preview a feature or product
- Complete simple tasks in seconds
- Skip downloading your full app (unless they want to)

When a user invokes an App Clip (via QR, NFC, Safari, Maps, etc.), it slides up from the bottom of the screen and launches instantly.

---

## Key Concepts

### Instant Experience
- Must be **under 10 MB**
- Loads quickly
- Gets users to action in **under 5 seconds**

### Discoverability
Users can launch App Clips from:
- QR codes
- NFC tags
- App Clip Codes
- Safari links
- Maps previews
- Links from your full app

### Focused Scope
Each App Clip does **one thing well** (like renting a bike or checking in).  
You only include the necessary frameworks and UI.

---

## Where to Learn More

### Official Apple Documentation
- [App Clip Framework Reference](https://developer.apple.com/documentation/appclip)
- [Creating an App Clip with Xcode](https://developer.apple.com/documentation/appclip/creating-an-app-clip-with-xcode)
- [Associate Your App Clip with Your Website](https://developer.apple.com/documentation/appclip/associating-your-app-clip-with-your-website)

### Human Interface Guidelines
- [App Clips Design Principles](https://developer.apple.com/design/human-interface-guidelines/app-clips)
- [App Clip Codes](https://developer.apple.com/documentation/appclip/creating-app-clip-codes)

### WWDC Sessions
- [Explore App Clips (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10174)
- [Design Great App Clips (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10172)
- [What’s New in App Clips (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10012)
- [Build Light and Fast App Clips (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10013)
- [What’s New in App Clips (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10097)
- [What’s New in App Clips (WWDC 2023)](https://developer.apple.com/videos/play/wwdc2023/10178)

---

## Visual App Clip Demo (Explained Simply)

This demo shows how to use an App Clip—a lightweight version of your app that launches instantly.

### What It Does
- Displays a **product preview** (like a new iPhone)
- Shows image, name, description, and a button
- When the user taps **Open Full App**, it transitions into the full app (if installed)

### Why It’s Cool
- Instant experience without downloading the full app
- If users are interested, they get the **full app’s richer experience**
- Shows the full app is more than one screen

### Behind the Scenes (Non-Technical)
- App Clip and Full App share the same codebase
- The App Clip is fast and simple, just enough to **spark interest**
- When launching the full app, it **remembers the product** and shows full info using a **deep link**

---

## Context & Relevance

App Clips were introduced at **WWDC 2020** as a way to offer **contactless, fast experiences**—especially useful in the post-pandemic world.  
They support features like **Apple Pay** and **Sign In with Apple** for secure, private transactions.

