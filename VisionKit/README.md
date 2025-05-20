# VisionKit – Document & Image Analysis UI Framework by Apple

VisionKit is Apple’s high-level document and image analysis UI framework, built on top of the Vision APIs. It offers plug-and-play view controllers that eliminate the need to manually wire up `AVCapture` sessions or Vision requests.

> Features include document scanning, barcode recognition, subject lifting, Live Text interaction, QR code scanning, and Visual Look Up—all through ready-made UI components.

---

## Key Components

- **VNDocumentCameraViewController** – Scan and capture documents with automatic edge detection  
- **DataScannerViewController** – Live text, barcode, and data detection through the camera  
- **ImageAnalysisInteraction** – Adds tappable overlays for recognized text, subjects, and detected items in static images

---

## Official Documentation

- [VisionKit Overview](https://developer.apple.com/documentation/visionkit/) – Entry point for the VisionKit framework  
- [Scanning Data with the Camera](https://developer.apple.com/documentation/visionkit/scanning-data-with-the-camera/) – Guide to using `DataScannerViewController`  
- [VNDocumentCameraScan Reference](https://developer.apple.com/documentation/visionkit/vndocumentcamerascan/) – Class for handling scanned document results

---

## Human Interface Guidelines

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) – General design guidance (no VisionKit-specific HIG)

---

## Recommended WWDC Sessions

- [What’s New in VisionKit (WWDC23)](https://developer.apple.com/videos/play/wwdc2023/10048/) – Updates on Live Text, subject lift, and QR enhancements  
- [Capture Machine-Readable Codes and Text (WWDC22)](https://developer.apple.com/videos/play/wwdc2022/10025/) – Integrating camera-based text and code scanning  
- [Vision Framework Overview](https://developer.apple.com/documentation/vision/) – For low-level capabilities and features beyond VisionKit

---

## Example App

**Scanner Plus: OCR,PDF,Docs** – A simple, user-friendly document scanner that processes all OCR locally via VisionKit and stores documents on-device or in iCloud


**Download**: [Scanner Plus: OCR,PDF,Docs on the App Store](https://apps.apple.com/us/app/scanner-plus-ocr-pdf-docs/id1329204203) – *Free*


![image](https://github.com/user-attachments/assets/008e0907-c5f7-4518-ad73-3d17f90a384f)
