# Create ML + Core ML Overview

Apple makes it easy to add machine learning to your apps — even if you’ve never written AI code.

- **Create ML**: A user-friendly macOS app and framework for training custom machine learning models — **no code needed**.
- **Core ML**: The engine that **runs those models on-device**, fast and securely — even without internet.

Together, they let you go from raw data to smart app features like:
- Predicting customer behavior
- Recognizing images
- Classifying text
- Analyzing trends

---

## Key Components

| Tool      | Purpose                                    |
|-----------|--------------------------------------------|
| Create ML | Train machine learning models (no code)    |
| Core ML   | Run trained models on iPhone, iPad, Mac    |

---

## Official Documentation

- [Create ML Docs](https://developer.apple.com/documentation/createml)
- [Core ML Docs](https://developer.apple.com/documentation/coreml)
- [Machine Learning Overview](https://developer.apple.com/machine-learning/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

---

## Recommended WWDC Sessions

- [Introducing the Create ML App (WWDC19)](https://developer.apple.com/videos/play/wwdc2019/430/)
- [Create ML Components for Advanced Models (WWDC22)](https://developer.apple.com/videos/play/wwdc2022/10019/)
- [Deploy ML On-Device with Core ML (WWDC24)](https://developer.apple.com/videos/play/wwdc2024/10161/)

---

## Understanding Tabular Data

Tabular data is like a spreadsheet:
- Each **row** = one example (e.g., a customer)
- Each **column** = one feature (e.g., age, income)

###  Loading Data
- Use a simple `.csv` file
- Create ML turns it into an `MLDataTable` — no code needed

### Training a Model
- Choose your **target column** (what you want to predict)
- Choose your **feature columns** (what you know)
- Create ML finds patterns (e.g., "Older customers with high income are likely to buy")

###  Core ML Integration
- Export the model as `.mlmodel`
- Drop it into Xcode
- Xcode auto-generates a Swift class
- You call it with input values and get predictions instantly

> If your data fits in rows and columns — you can use it:  
> ✅ Sales records  
> ✅ Sensor readings  
> ✅ Survey results

---

## WillBuy Predictor Demo — How It Works

A simple SwiftUI app that predicts whether someone will buy a product based on age and income.

### 1. Training Data
- CSV file with:
  - **Age**
  - **Income**
  - **Will Buy**: yes / no

### 2. Create ML App
- Dragged CSV into the app
- Set `willBuy` as the target
- Trained and exported a model

### 3. Core ML in Xcode
- Added `.mlmodel` to the project
- Xcode created `WillBuyClassifier.swift` for us

### 4. User Interface
- SwiftUI form to input:
  - Age
  - Income
- Tap **Predict**
- App shows:
  - ✅ “Likely to buy”  
  - ❌ “Unlikely to buy”

### 5. Visualization
- Simple chart overlays the training data
- Shows where your input lands in the decision space

---

## Summary

- No ML background required
- Fast, private, **on-device predictions**
- Great for educational, commercial, or prototyping apps

> Whether you’re a total beginner or a seasoned dev, Create ML + Core ML let you turn data into decisions — beautifully and simply.

---

# Photomator – Photo Editor (Found in App Store)

**Download**: [Photomator on the App Store](https://apps.apple.com/us/app/photomator-photo-editor/id1444636541?uo=2) – *Free*

<img width="300" alt="Screenshot 2025-05-07 at 4 16 16 PM" src="https://github.com/user-attachments/assets/4799d7b6-017b-4bd2-b5df-04c65cbe6383" />

---

### Overview

Photomator is a powerful, AI-enhanced photo editor designed exclusively for iPhone, iPad, and Mac. Built on Apple-native technologies—SwiftUI, Metal, Core Image, and Core ML—it enables fast, non-destructive editing with professional-quality tools and effects. Perfect for photographers of all levels.

---

### Core ML Integration

- **ML Super Resolution**: Upscale images up to 3× using a Core ML model, with on-device inference powered by the Apple Neural Engine for sharp, high-resolution results.
- **Background Removal**: Instantly isolate subjects using a semantic segmentation `.mlmodel`, enabling one-tap background removal.
- **Smart Tone & Color**: Automatically enhances exposure, contrast, and color vibrancy using Core ML models trained on professional image adjustments.
- **Subject Selection**: Quickly select people, pets, and objects via Core ML object-detection models for targeted editing and precise masking.

