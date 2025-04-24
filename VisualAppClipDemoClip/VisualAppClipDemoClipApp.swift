//
//  VisualAppClipDemoClipApp.swift
//  VisualAppClipDemoClip
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import SwiftData

import SwiftUI

@main
struct VisualAppClipDemoClipApp: App {
    @State private var product: Product? = nil

    var body: some Scene {
        WindowGroup {
            Group {
                if let product = product {
                    ProductView(product: product)
                } else {
                    Text("Loading product...")
                        .onAppear {
                            handleLaunch(url: URL(string: "https://demo.appclip/product?id=001")!)
                        }
                }
            }
        }
    }

    func handleLaunch(url: URL) {
        // Extract the query item
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let id = components.queryItems?.first(where: { $0.name == "id" })?.value,
           let product = sampleProducts[id] {
            self.product = product
        }
    }
}
