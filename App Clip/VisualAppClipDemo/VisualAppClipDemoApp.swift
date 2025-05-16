//
//  VisualAppClipDemoApp.swift
//  VisualAppClipDemo
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import SwiftData

@main
struct VisualAppClipDemoApp: App {
    @State private var launchedProductID: String? = nil

    var body: some Scene {
        WindowGroup {
            Group {
                if let id = launchedProductID, let product = sampleProducts[id] {
                    ProductDetailView(product: product)
                } else {
                    Text("Welcome to the full app!")
                }
            }
            .onOpenURL { url in
                if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                   let id = components.queryItems?.first(where: { $0.name == "id" })?.value {
                    launchedProductID = id
                }
            }
        }
    }
}
