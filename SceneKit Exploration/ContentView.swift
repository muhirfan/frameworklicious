//
//  ContentView.swift
//  SceneKit Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = SceneKitController()

    var body: some View {
        VStack {
            SceneKitView(controller: controller)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Button("Jump") {
                                controller.jump()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())

                            Button("Spin") {
                                controller.spin()
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())

                            Button("Toggle Gravity") {
                                controller.toggleGravity()
                            }
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                        .padding()
                    }
                )
        }
    }
}

#Preview {
    ContentView()
}
