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

---

# Calendars – Planner & Organizer (Found in App Store)

**Download**: [Calendars on the App Store](https://apps.apple.com/us/app/calendars-planner-organizer/id608834326) – *Free*

<img width="300" alt="Screenshot 2025-05-07 at 4 32 45 PM" src="https://github.com/user-attachments/assets/406873ad-6dc7-4bc0-b494-77e4b77777d5" />

---

### Overview

Calendars – Planner & Organizer unifies your iCloud, Google, Exchange, and local calendars in one intuitive interface built on Apple’s native calendar APIs. Offering Day, Week, and Month views, it allows you to create, manage, and sync both events and reminders directly within the app using EventKit.

---

### EventKit Integration

- **Permission Handling**: Requests access using `EKEventStore().requestAccess(to: .event)` and handles denial with user-friendly fallback messaging.
- **Event Fetching**: Loads events 30 days before and after the current date using `predicate(forEventsMatching:startDate:endDate:calendars:)` for efficient data queries.
- **Native UI Controllers**: Uses `EKEventEditViewController` for consistent “New Event” and “Edit Event” screens matching the native Calendar app.
- **Calendar Chooser**: Integrates `EKCalendarChooser` from EventKitUI to let users select which calendars to show—no custom UI required.
- **Immediate Refresh**: Triggers `eventStore.reset()` and reloads the list when changes are made, ensuring real-time updates with no manual refresh needed.

---

### Key Features

- **Drag & Drop Rescheduling**: Move events directly on the timeline—EventKit automatically handles saving and syncing.
- **Reminders Integration**: Toggle between events and reminders using EventKit’s `.event` and `.reminder` types in the same interface.
- **Cross-Device Sync**: iCloud sync ensures all updates appear on every device automatically via the Calendar database.
- **Multiple Calendar Support**: Connect and toggle visibility for iCloud, Google, Exchange, and local calendars—all managed as `EKCalendar` instances.
