# EventKit Framework Exploration

**EventKit** is Apple’s framework for accessing and managing the Calendar and Reminders on a user’s device.  
With just a few lines of code, your app can view, create, and update real calendar events — just like the built-in Calendar app.

This demo app shows how to build a lightweight custom calendar interface using **EventKit** and **EventKitUI**.

---

## What Is EventKit?

- **EventKit** lets your app **create, read, and edit** calendar events and reminders.
- It handles **permission requests** so you only ask the user once.
- Combined with **EventKitUI**, you get **Apple-native view controllers** to display or edit events — no need to build custom UIs from scratch.

---

## What This App Does

A simple, iPhone-style calendar app clone — in a tiny standalone package.

### Ask Permission
- On first launch, the app asks:  
  _"May I access your calendars?"_
- iOS shows the standard permission dialog.
- If allowed, the app proceeds; if not, it won't access anything.

### Show Your Events
- Once granted access:
  - The app loads real events from **30 days ago through the next 30 days**.
  - They appear in a scrollable list titled **“My Calendar.”**

### Add a New Appointment
- Tap the **＋** button in the top-right corner.
- A familiar **“New Event” screen** appears (just like the system Calendar).
- It’s pre-filled with a 1-hour slot starting **right now**.

### Save or Cancel
- Tap **Save** to write it into your iPhone’s actual calendar.
- Tap **Cancel** to discard — no data is changed.

### Instant Refresh
- After saving, the app updates automatically.
- Your new event appears right away — no manual refresh needed.

### Feels Native
- All UI elements are **Apple’s own**, thanks to EventKitUI.
- You’re interacting with your **actual calendar data**, not sample placeholders.

---

## Official Resources

### Documentation
- [EventKit Framework Reference](https://developer.apple.com/documentation/eventkit)
- [EventKitUI Framework Reference](https://developer.apple.com/documentation/eventkitui)
- [Sample Code: Accessing Calendar](https://developer.apple.com/documentation/eventkit/accessing-calendar-using-eventkit-and-eventkitui)

### Human Interface Guidelines
- [General HIG](https://developer.apple.com/design/human-interface-guidelines)
- [Date & Time Pickers](https://developer.apple.com/design/human-interface-guidelines/components/pickers/)
- [Popovers](https://developer.apple.com/design/human-interface-guidelines/components/popovers/)
- [Privacy Guidelines](https://developer.apple.com/design/human-interface-guidelines/privacy/)

### WWDC Sessions
- [Discover Calendar and EventKit (WWDC23)](https://developer.apple.com/videos/play/wwdc2023/10052/)
- [YouTube Mirror](https://www.youtube.com/watch?v=ibfwUwv_2K8)

---

## Summary

This demo shows how **easy** and **powerful** it can be to use Apple’s frameworks to:
- Work with real calendar data
- Use native interfaces
- Create a professional-feeling calendar tool — even as a beginner
