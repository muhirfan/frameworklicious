# SceneKit Framework Overview

**SceneKit** is Apple’s built-in 3D graphics framework that lets you create interactive scenes and animations — **without writing low-level graphics code**.  
It’s designed for developers who want to build rich 3D content using a high-level, descriptive API.

With SceneKit, you can easily add:
- 🧊 3D objects
- 💡 Lights
- 🎥 Cameras
- 🧲 Physics
- ✨ Particle effects

This makes it a powerful tool for building everything from visualizations to immersive games or AR scenes.

---

## Official Documentation

- [SceneKit Developer Docs](https://developer.apple.com/documentation/scenekit/)
- [Apple HIG (Human Interface Guidelines)](https://developer.apple.com/design/human-interface-guidelines/)
- [AR HIG (for Augmented Reality apps)](https://developer.apple.com/design/human-interface-guidelines/augmented-reality/)

---

## WWDC Videos

- [SceneKit: What’s New (WWDC 2017)](https://developer.apple.com/videos/play/wwdc2017/604/)
- [SceneKit in Swift Playgrounds (WWDC 2017)](https://developer.apple.com/videos/play/wwdc2017/605/)
- [Ingredients of Great Games (WWDC 2014)](https://developer.apple.com/videos/play/wwdc2014/602/)

---

## Additional Resources

- [SceneKit with Swift – Part 1 (Kodeco)](https://www.kodeco.com/2243-scene-kit-tutorial-getting-started)

---

## About This Demo App

This is a **simple SceneKit demo** that places a 3D cube in a scene. Users can interact with it using on-screen buttons.

### Features

- **Jump:** Pressing “Jump” gives the cube a boost upwards (gravity pulls it back down).
- **Spin:** Makes the cube rotate continuously.
- **Fun Mode:** Enables random 3D shapes (spheres, cones, pyramids, boxes) to drop around the cube every second.

� Just tap the buttons to see the cube and objects interact in a dynamic 3D world.

---

SceneKit helps you bring creative 3D ideas to life — whether you're building a game, visual effect, or just exploring what's possible with iOS graphics.

---

# Metaspace – 3D Sketchbook (Found in App Store)

**Download**: [Metaspace on the App Store](https://apps.apple.com/us/app/metaspace-3d-sketchbook/id1438400795?uo=2) – *Free*

<img width="300" alt="Screenshot 2025-05-07 at 4 27 56 PM" src="https://github.com/user-attachments/assets/85db42d5-51b9-4081-9ae2-4a12139a06f4" />

---

### Overview

Metaspace is an infinitely expanding 3D sketchbook that empowers you to draw freely using pressure- and tilt-sensitive pencils, pens, and markers. With full Apple Pencil support on iPad and touch support on all devices, it enables users to visualize ideas and build immersive mind maps on a true three-dimensional canvas.

---

### SceneKit Integration

- **High-Level 3D Rendering**: Uses SceneKit to manage 3D scene graph rendering, lighting, and camera movement without the need for low-level Metal or OpenGL.
- **AR Exploration Mode**: Combines ARKit and SceneKit to overlay your drawings into the real world using the back camera—ideal for immersive walk-throughs.
- **Touch-Driven Camera Controls**: Implements `SCNView` to enable intuitive pan, zoom, and rotate gestures for navigating the 3D canvas.
- **Real-Time Scene Updates**: Ensures instant rendering of strokes and models through SceneKit’s efficient scene graph and rendering loop.

---

### Key Features

- **3D Drawing Tools**: Sketch with realistic pencils, pens, markers, and brushes that respond to tilt and pressure.
- **Infinite Canvas**: Build limitless 3D ideas—ideal for concepting, storytelling, or mind mapping without spatial constraints.
- **Import & Overlay**: Load USDZ and other 3D assets, then draw directly on top for markup and annotation.
- **Animated Walkthroughs**: Record navigation paths through your scenes to present ideas or designs dynamically.
- **Multi-Device Sync**: Use seamlessly across iPhone, iPad, Apple Silicon Mac, and Apple Vision—your 3D creations follow you.
- **Free to Use**: Get started at no cost. Optional in-app purchases unlock export tools, file management, and collaboration features.

