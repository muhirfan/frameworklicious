# CoreLocation Framework Overview

Core Location abstracts complex GPS, compass, and sensor data processing behind a few simple classes, so you can start receiving location updates with just a few lines of code. It supports both one-time location requests and continuous tracking modes, letting you choose between immediate fixes or ongoing updates for activities like turn-by-turn navigation.

Beyond basic tracking, Core Location offers advanced features like **region monitoring** (geofencing), where your app is notified when a user enters or leaves geographic areas, and **visit monitoring**, which records when people arrive at or depart from significant locations. Recent updates also introduce energy-efficient enhancements—such as **batched location deliveries** and improved **background handling**—to reduce battery usage while keeping your app informed.

---

## What is CoreLocation?

At its core, Core Location is a set of **Swift** and **Objective-C** APIs for requesting and receiving location data from the operating system.

### Primary Workflow

1. Create a `CLLocationManager` instance to manage all location-related behavior.
2. Configure desired accuracy and request appropriate permissions (e.g., "When In Use" or "Always").
3. Start updates with:
   - `startUpdatingLocation()` (continuous updates)
   - `requestLocation()` (one-time location)
4. Implement delegate callbacks or async handlers to receive `CLLocation` objects, which include:
   - latitude
   - longitude
   - altitude
   - accuracy
   - timestamp

### Extended Capabilities

| Feature         | Class/Functionality                | Description                                                 |
|-----------------|------------------------------------|-------------------------------------------------------------|
| Geofencing      | `CLRegion`                         | Monitor entry/exit from circular geographic regions         |
| Visit Detection | `CLVisit`                          | Detect when users arrive or leave significant places        |
| Beacon Ranging  | `CLBeaconRegion`                   | Support for iBeacon proximity-based services                |
| Location UI     | `CLLocationButton`                 | System-provided button for requesting location permission   |

---

## Resources

### Official Documentation

- [Core Location API Reference](https://developer.apple.com/documentation/corelocation/)
- [CLLocationManager Class Reference](https://developer.apple.com/documentation/corelocation/cllocationmanager)

### Human Interface Guidelines

- [Maps & Location HIG](https://developer.apple.com/design/human-interface-guidelines/maps/)  
  Best practices for displaying user position, requesting permissions, and designing map interfaces.

### WWDC Videos

- [Meet the Location Button (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10102/)  
  Learn how to use the `CLLocationButton` UI control to request location access with minimal friction.

- [What’s New in Location Authorization (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10212/)  
  Explore improvements to the authorization model, including streamlined permission requests and service sessions.
