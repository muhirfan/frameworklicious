# CoreBluetooth Framework Overview

**CoreBluetooth** is Apple’s built-in framework for communicating with Bluetooth devices — like fitness trackers, headphones, or custom sensors — using Bluetooth Low Energy (BLE).  
It lets your app **discover, connect to, and exchange data** with nearby accessories, all without managing the low-level Bluetooth protocol.

---

## What Is CoreBluetooth?

- CoreBluetooth lets your app work with **BLE (Bluetooth Low Energy)** and **Classic Bluetooth (BR/EDR)** on iOS, macOS, watchOS, and tvOS.
- You don’t need to understand packets or protocol layers — Apple gives you a **simple API** for:
  - Scanning for devices
  - Connecting to them
  - Reading/writing data

---

## How This Demo App Works

This sample SwiftUI app showcases **both the Central and Peripheral roles** of CoreBluetooth — in one interface.

### Central Role
- **Scans** for nearby BLE devices.
- Displays them in a list with:
  - Device name
  - Signal strength (RSSI)
- Lets you tap **“Connect”** to initiate pairing.

### Peripheral Role
- **Advertises** a custom Bluetooth service:
  - UUID: `FFE0`
  - Characteristic: `FFE1`
- Responds to read requests by sending the message:  
  _“Hello from Peripheral.”_
- Controlled using a simple SwiftUI **Toggle**.

### State Management
- Uses a shared `BluetoothManager` class:
  - Implements both `CBCentralManagerDelegate` and `CBPeripheralManagerDelegate`
  - Publishes changes (e.g., discovered devices, connection state) to the UI

### User Interface
- Built with **SwiftUI**
- Uses `@EnvironmentObject` to link `BluetoothManager` to the UI
- Displays:
  - Bluetooth power status
  - Scanning controls
  - List of found devices
  - Advertising toggle

---

## Official Resources

### Documentation
- [Core Bluetooth Framework Reference](https://developer.apple.com/documentation/corebluetooth)
- [Apple Bluetooth Overview Hub](https://developer.apple.com/bluetooth/)

### Human Interface Guidelines
- [Privacy Prompts (HIG)](https://developer.apple.com/design/human-interface-guidelines/privacy/)

---

## Recommended WWDC Sessions

- [What’s New in Core Bluetooth (WWDC 2019)](https://developer.apple.com/videos/play/wwdc2019/901/)
- [Connect Bluetooth Devices to Apple Watch (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10005/)
- [Get Alerts from Bluetooth Devices on watchOS (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10135/)

---

## Why Use CoreBluetooth?

- Build apps for **health, fitness, smart home, sensors**, and more.
- Works across **iPhone, iPad, Mac, Apple Watch, Apple TV**
- Enables background scanning, notifications, and **secure data transfer**.

---

## Summary

CoreBluetooth may sound technical, but with this SwiftUI-powered demo app:
- Non-coders can **see devices** and **send messages**
- Developers get a clean, modern example to **build real-world Bluetooth experiences**

Let your app talk to the world — wirelessly !
