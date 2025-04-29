# MapKit Framework Overview

The **MapKit** framework lets you embed interactive, scrollable maps in your apps—handling map display, annotations, overlays, geocoding, local search, and routing **without any server setup**.

- SwiftUI’s declarative `Map` view enables quick, fully interactive map integration in just a few lines.
- UIKit’s `MKMapView` offers full delegate-based customization of map behavior and appearance.
- Apple's **Human Interface Guidelines** provide best practices for map interaction, annotation design, and user-location features.
- For the latest features—such as 3D City Experience, Look Around API, and Place Card integration—see WWDC sessions:
  - "What’s New in MapKit" (WWDC 2022)
  - "Meet MapKit for SwiftUI" (WWDC 2023)
  - "Unlock the Power of Places with MapKit" (WWDC 2024)

---

## What Is MapKit?

**MapKit** is Apple’s native mapping SDK, available on **iOS**, **iPadOS**, **macOS**, **watchOS**, and **tvOS**, enabling developers to add rich map functionality without building a map engine from scratch.

- Powers the built-in **Apple Maps** app.
- Freely available for any developer to embed maps in their apps.

### Key Components

| Feature | API |
|---------|-----|
| Map Views | `MKMapView` (UIKit) / `Map` (SwiftUI) |
| Annotations | `MKAnnotation`, `MapMarker` for custom pins and callouts |
| Overlays | `MKOverlay` for drawing polylines, polygons, and circles |
| Geocoding | `CLGeocoder` for address-to-coordinate conversion |
| Local Search | `MKLocalSearch` for finding nearby POIs |
| Routing | `MKDirections` for driving, walking, and transit directions |
| Web Integration | `MapKit JS` to embed maps in web pages |

---

## Links

### Official Documentation

- [MapKit Framework Reference](https://developer.apple.com/documentation/mapkit)
- [MapKit for SwiftUI](https://developer.apple.com/documentation/mapkit/mapkit-for-swiftui)
- [MapKit JS (Web)](https://developer.apple.com/documentation/mapkitjs)

### Human Interface Guidelines

- [Maps Overview HIG](https://developer.apple.com/design/human-interface-guidelines/maps)

### WWDC Sessions

- [What’s New in MapKit (WWDC 2022)](https://developer.apple.com/videos/play/wwdc2022/10035/)
- [Meet MapKit for SwiftUI (WWDC 2023)](https://developer.apple.com/videos/play/wwdc2023/10043/)
- [Unlock the Power of Places with MapKit (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10097/)

---

## How This App Works

This sample project demonstrates MapKit basics and core interactions:

- **Launch**: Centers the map on San Francisco by default.
- **Live Location**: Requests "When In Use" permission, then recenters the map to your current position after grant.
- **Map Interaction**:
  - **Long-press** anywhere: Drop a custom pin.
  - **Geocode Address**: Enter an address to place a pin.
  - **Search POI**: Search for keywords (e.g., "café") to find nearby points of interest.
  - **Routing**: Tap "Route" to draw a driving path from your live location to the nearest pin.
- **Map Style**: Switch between Standard, Satellite, or Hybrid views.
- **Traffic**: Toggle real-time traffic overlays.
- **Reset**: Clear all pins and route overlays and pan/zoom back to your live location.

Enjoy experimenting with MapKit’s core capabilities, and refer to the links above for deeper exploration of advanced topics like clustering, 3D camera control, and Look Around!

---
