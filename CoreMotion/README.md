# Core Motion Framework Overview

**Core Motion** is Apple’s high-level framework that gives your app access to motion and environmental sensor data — like **steps, rotation, acceleration, elevation, and activity type** — using simple APIs.

You don’t need to manage raw sensor data manually. Core Motion handles that for you using the **motion coprocessor** built into Apple devices.

---

## What Is Core Motion?

Core Motion provides **continuous, power-efficient motion data** from onboard sensors:

- **Accelerometer**: Linear acceleration in 3D space
- **Gyroscope**: Rotational velocity
- **Pedometer**: Steps, distance walked, floors climbed
- **Altimeter**: Changes in elevation (barometric pressure)
- **Activity Recognition**: Detects walking, running, cycling, driving, etc.

Motion data is processed on a **dedicated chip** so it uses less battery — even when the app isn’t active.

---

## Key Features

| Feature                     | Description                                                             |
|----------------------------|--------------------------------------------------------------------------|
| High-Frequency Streaming | CMMotionManager provides up to **100 Hz** (even 800 Hz on newer watchOS)   |
| Step Counting            | CMPedometer tracks **live and historical steps**, distance, floor changes  |
| Altitude Updates         | CMAltimeter provides real-time **elevation changes** using the barometer   |
| Activity Detection       | CMMotionActivityManager identifies **walk/run/drive/cycle** in real time   |
| Unified Motion Data      | CMDeviceMotion fuses accelerometer, gyroscope, and magnetometer into one   |

---

## Core Motion APIs

| API                     | Purpose                                                                 |
|-------------------------|-------------------------------------------------------------------------|
| `CMMotionManager`       | Start/stop accelerometer, gyroscope, and device motion updates          |
| `CMPedometer`           | Track steps, distance, floors using `startUpdates(from:withHandler:)`   |
| `CMAltimeter`           | Report altitude using `startRelativeAltitudeUpdates(to:withHandler:)`   |
| `CMMotionActivityManager` | Detect motion type using `startActivityUpdates(to:withHandler:)`      |
| `CMDeviceMotion`        | Unified motion data: gravity, attitude, rotation rate, acceleration     |

---

## Resources

### Official Documentation
- [Core Motion API Reference](https://developer.apple.com/documentation/coremotion/)
- [Core Motion (Objective-C)](https://developer.apple.com/documentation/CoreMotion?language=objc)

### Human Interface Guidelines
- [Gyroscope and Accelerometer in HIG](https://developer.apple.com/design/human-interface-guidelines/gyro-and-accelerometer/)

---

## WWDC Sessions

- [What’s New in Core Motion (WWDC 2023)](https://developer.apple.com/videos/play/wwdc2023/10179/)  
  High-frequency streaming, submersion detection, and AirPods motion APIs

- [Core Motion Updates (WWDC 2015)](https://developer.apple.com/videos/play/wwdc2015/705/)  
  Pedometer and altimeter APIs, Apple Watch support

---

## Final Thoughts

Core Motion makes it easy to build motion-aware features like:
- Fitness tracking
- Step counters
- Elevation-based stats (stairs climbed)
- Detecting walking vs. driving

> With minimal battery impact and simple Swift APIs, Core Motion is perfect for creating **context-aware, motion-powered apps**.
