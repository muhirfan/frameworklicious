//
//  ProductView.swift
//  VisualAppClipDemo
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import SwiftUI

struct ProductView: View {
    var product: Product

    var body: some View {
        let openURL = Environment(\.openURL).wrappedValue

        VStack(spacing: 20) {
            Image(systemName: product.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()

            Text(product.name)
                .font(.title)
                .fontWeight(.bold)

            Text(product.description)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Open Full App") {
                if let url = URL(string: "myappclipdemo://product?id=\(product.id)") {
                    openURL(url)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
