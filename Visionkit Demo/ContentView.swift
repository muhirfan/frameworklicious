//
//  ContentView.swift
//  Visionkit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import VisionKit
import Vision

struct ContentView: View {
    @State private var showScanner = false
    @State private var scannedImages: [UIImage] = []
    @State private var extractedTexts: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                if !scannedImages.isEmpty {
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(Array(scannedImages.enumerated()), id: \ .offset) { index, image in
                                VStack(alignment: .leading) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 200)
                                        .border(Color.gray)
                                    Text("Extracted Text:")
                                        .font(.headline)
                                    ScrollView {
                                        Text(extractedTexts.indices.contains(index) ? extractedTexts[index] : "Recognizing...")
                                            .font(.caption)
                                            .padding(4)
                                    }
                                    .frame(width: 150, height: 100)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    Spacer()
                    Text("No scans yet. Tap ‘Scan Document’ to start.")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationBarTitle("VisionKit Demo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showScanner = true
            }) {
                Text("Scan Document")
            })
            .sheet(isPresented: $showScanner) {
                DocumentScannerView { images in
                    scannedImages = images
                    performTextRecognition(on: images)
                }
            }
        }
    }

    private func performTextRecognition(on images: [UIImage]) {
        extractedTexts = Array(repeating: "", count: images.count)

        for (i, image) in images.enumerated() {
            guard let cgImage = image.cgImage else {
                extractedTexts[i] = "Invalid image"
                continue
            }

            let request = VNRecognizeTextRequest { request, error in
                DispatchQueue.main.async {
                    if let observations = request.results as? [VNRecognizedTextObservation] {
                        let text = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
                        extractedTexts[i] = text.isEmpty ? "No text found" : text
                    } else if let error = error {
                        extractedTexts[i] = "Error: \(error.localizedDescription)"
                    }
                }
            }
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    DispatchQueue.main.async {
                        extractedTexts[i] = "Recognition failed"
                    }
                }
            }
        }
    }
}
