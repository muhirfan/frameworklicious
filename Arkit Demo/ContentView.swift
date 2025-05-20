//
//  ContentView.swift
//  Arkit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        ZStack {
            // Fullscreen ARView
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("Tap anywhere to place a blue box")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
