//
//  ProductView.swift
//  VisualAppClipDemo
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import SwiftUI

struct ProductView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "iphone.gen3")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            Text("Introducing the iPhone Future")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Experience the future of mobile technology, now in the palm of your hand.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                print("Pretend to buy or open full app!")
            }) {
                Text("Buy Now")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ProductView()
}
