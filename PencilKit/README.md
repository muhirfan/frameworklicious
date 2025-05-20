# PencilKit Framework Overview

PencilKit provides a `PKCanvasView`—a view that captures Apple Pencil or touch input and displays it as a high-fidelity drawing—plus a `PKToolPicker` palette for selecting inks, pencils, erasers, and more. It automatically manages rendering performance and input smoothing, delivering low-latency strokes so drawings feel natural and precise. The framework also defines a `PKDrawing` object to represent the entire sketch and `PKStroke` objects for each continuous line, all of which you can save, load, and manipulate programmatically.

---

## What Is PencilKit?

At its core, PencilKit is a set of **Swift**/**Objective-C** APIs that wrap complex touch and stylus handling into easy-to-use classes:

| Class | Purpose |
|-------|---------|
| `PKCanvasView` | The visible drawing surface that accepts strokes from Apple Pencil or the user’s finger. |
| `PKToolPicker` | The toolbar of drawing tools (pens, pencils, erasers) users interact with to change colors and brush styles. |
| `PKDrawing` | A data model object that stores all strokes and attributes of the current drawing, which you can serialize and persist. |
| `PKStroke` | Represents individual stroke paths within a drawing, each with its own ink type and width. |
| `PKInkingTool`, `PKEraserTool`, `PKLassoTool` | Predefined tool classes for different drawing actions. |

You simply add a `PKCanvasView` to your UI, connect a `PKToolPicker`, and you’re ready to draw—no manual gesture handling or rendering code required.

---

## Resources

### Official Documentation

- [PencilKit API Reference](https://developer.apple.com/documentation/pencilkit/)
- [Drawing with PencilKit (Sample Code)](https://developer.apple.com/documentation/pencilkit/drawing-with-pencilkit)
- [PKCanvasView Class Reference](https://developer.apple.com/documentation/pencilkit/pkcanvasview)

### Human Interface Guidelines

- [Apple Pencil and Scribble HIG](https://developer.apple.com/design/human-interface-guidelines/apple-pencil-and-scribble/)  
  Best practices for integrating Apple Pencil input and annotations into your app’s interface.

### WWDC Videos

- [Introducing PencilKit (WWDC 2019)](https://developer.apple.com/videos/play/wwdc2019/221/)
- [Inspect, Modify, and Construct PencilKit Drawings (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10148/)
- [What’s New in PencilKit (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10107/)
- [Squeeze the Most Out of Apple Pencil with PencilKit (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10214/)
