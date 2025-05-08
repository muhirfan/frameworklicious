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

---

# SignEasy – App Clip for E-Signatures (Found via App Clip)

**Download Full App**: [SignEasy on the App Store](https://apps.apple.com/us/app/signeasy-sign-send-documents/id381786507?uo=2) – *Free*

<img width="300" alt="Screenshot 2025-05-08 at 2 16 59 PM" src="https://github.com/user-attachments/assets/c9b84726-ef37-41ec-b32d-ede5d571b085" />


---

### Overview

SignEasy’s App Clip delivers a fast, lightweight e-signature experience that allows users to view, sign, and send documents instantly—no full app download required. Weighing under 10 MB, it launches quickly via QR code, NFC tag, Smart App Banner, or direct App Clip link.

---

### App Clip Integration

- **Quick Document Signing**: Launch via QR code or NFC tag to open a simplified document review and signing UI modeled after the full app experience.
- **Secure Authentication**: Supports Sign In with Apple for fast login and Apple Pay for any required payments—no extra setup needed.
- **Deep Linking with Context**: Uses invocation URLs (e.g., `appclip.apple.com/id?p=com.signeasy.appclip`) to open specific signing sessions with prefilled fields.
- **Seamless Full App Transition**: After signing, users are prompted to open or download the full SignEasy app—with session data carried over via deep link.

---

### Key Features

- **Annotation Tools**: Add text, checkboxes, dates, and signature fields just like in the full app.
- **Download & Share**: Save or email signed documents directly from the App Clip session.
- **Privacy & Security**: Runs fully on-device with encrypted document handling and iCloud storage—no third-party access.
- **Consistent Branding**: Interface styling matches the full SignEasy app, delivering a familiar and polished user experience.

---

### Demo Video

▶**Watch the SignEasy App Clip in action**: [YouTube](https://signeasy.com/blog/features/app-clips-are-making-it-easier-than-ever-to-collect-esignatures)

---

### Learn More

**How App Clips simplify e-signatures**: [SignEasy Blog Post](https://signeasy.com/blog/features/app-clips-are-making-it-easier-than-ever-to-collect-esignatures)
