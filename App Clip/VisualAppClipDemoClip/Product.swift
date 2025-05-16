//
//  Product.swift
//  VisualAppClipDemo
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation

struct Product: Identifiable {
    let id: String
    let name: String
    let description: String
    let imageName: String
}

let sampleProducts: [String: Product] = [
    "001": Product(id: "001", name: "iPhone Future", description: "The next-gen smartphone experience.", imageName: "iphone.gen3"),
    "002": Product(id: "002", name: "Apple Vision", description: "Your world. Augmented.", imageName: "visionpro")
]
