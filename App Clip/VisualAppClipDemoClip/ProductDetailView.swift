//
//  ProductDetailView.swift
//  VisualAppClipDemo
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    var product: Product

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()

                Text(product.name)
                    .font(.largeTitle)
                    .bold()

                Text(product.description)
                    .font(.body)
                    .padding()

                Divider()

                Text("⭐️ 4.9 - Based on 2,340 reviews")
                    .foregroundColor(.gray)

                Button("Buy Now") {
                    print("Buy product \(product.id)")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Full Product Experience")
        .navigationBarTitleDisplayMode(.inline)
    }
}
