# FrameworkliciousCore (messages) Overview

FrameworkliciousCore exposes high-level managers and handlers that simplify common tasks in the Messages framework:

| Feature | Description |
|--------|-------------|
| Composing and sending messages | Use `FLCMessageManager` to create `MSMessage` objects and send them via `MSConversation.send(_:completionHandler:)`, without manual URL encoding or error handling. |
| Customizing message appearance | Wrap `MSMessageTemplateLayout` to set images, captions, and button titles for your messages in a few lines. |
| Managing interactive sessions | Automatically attach and update `MSSession` identifiers so messages stay linked to ongoing conversations, allowing updates to already-sent messages. |
| Handling conversation events | Delegate `MSMessagesAppViewController` callbacks (like `willBecomeActive(with:)`) through concise `FLCSessionController` methods. |
| Controlling presentation contexts | Simplify switching between compact, expanded, and in-conversation modes by abstracting `MSMessagesAppPresentationContext` logic into easy APIs. |

---

## What Is FrameworkliciousCore (messages) ?

FrameworkliciousCore is a set of **Swift** (and **Objective-C**) classes—such as `FLCMessageManager`, `FLCStickerHandler`, and `FLCSessionController`—that encapsulate Messages framework functionality behind a clean, consistent API.

### Key Steps

1. Install FrameworkliciousCore via **Swift Package Manager** or **CocoaPods**.
2. Import FrameworkliciousCore in your project.
3. Authenticate your extension by enabling the **Messages** capability in Xcode.
4. Instantiate high-level managers like `FLCMessageManager`.
5. Compose messages and control presentation contexts through one-line method calls.
6. React to message events via simple delegate protocols.

FrameworkliciousCore enables developers—especially beginners—to focus on designing fun message experiences like custom stickers or live-updating content without wrestling with low-level Messages framework APIs.

---

## Messages Aspect

FrameworkliciousCore wraps the Messages framework’s key classes:

| Class | Purpose |
|------|---------|
| `MSMessage` | Represents a rich message with media, a URL payload, and a template layout. FrameworkliciousCore simplifies initialization and customization. |
| `MSConversation` | Provides the active chat context. FrameworkliciousCore handles fetching the current conversation and sending/inserting messages. |
| `MSSession` | Identifies a sequence of related messages. FrameworkliciousCore abstracts session creation and reuse for message updates. |
| `MSMessageTemplateLayout` | Defines visual layouts (image, title, subtitle, caption, trailing text). The wrapper class ensures consistent styling easily. |
| `MSMessagesAppViewController` | Manages your extension’s lifecycle inside Messages. FrameworkliciousCore simplifies delegate methods into straightforward callbacks like `didBecomeActive()` and `willResignActive()`. |

### Error and State Handling

FrameworkliciousCore automatically:

- Checks `MSMessage.isPending` status.
- Surfaces `MSMessageErrorCode` values through friendly error handlers.
- Notifies when a message fails to send or update.

---

## Resources

### Official Documentation

- [Messages Framework Reference](https://developer.apple.com/documentation/messages/)
- [MSMessage Class Reference](https://developer.apple.com/documentation/messages/msmessage/)

### WWDC Videos

- [iMessage Apps and Stickers](https://developer.apple.com/imessage/)
- [Integrate your custom collaboration app with Messages (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10093/)
- [Enhance collaboration experiences with Messages (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10095/)
