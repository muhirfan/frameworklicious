//
//  ContentView.swift
//  Visionkit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @State private var showScanner = false
    @State private var scannedImages: [UIImage] = []

    var body: some View {
        NavigationView {
            VStack {
                if scannedImages.isEmpty {
                    Text("No documents scanned yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(scannedImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 250)
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .navigationTitle("VisionKit Demo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showScanner = true
                    } label: {
                        Label("Scan Document", systemImage: "doc.text.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $showScanner) {
                DocumentScannerView { images in
                    scannedImages = images
                }
            }
        }
    }
}
