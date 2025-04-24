//
//  ContentView.swift
//  SceneKit Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var sceneAction: SceneKitView.SceneAction = .none
    @State private var isFunModeOn = false

    var body: some View {
        VStack {
            SceneKitView(action: $sceneAction)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Spacer()

                        HStack(spacing: 20) {
                            Button("Jump") {
                                sceneAction = .jump
                            }
                            .buttonStyle(ActionButtonStyle(color: .blue))

                            Button("Spin") {
                                sceneAction = .spin
                            }
                            .buttonStyle(ActionButtonStyle(color: .purple))

                            Button(isFunModeOn ? "Stop Fun Mode" : "Start Fun Mode") {
                                isFunModeOn.toggle()
                                sceneAction = isFunModeOn ? .funMode : .none
                            }
                            .buttonStyle(ActionButtonStyle(color: .pink))
                        }
                        .padding()
                    }
                )
        }
    }
}

struct ActionButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(color.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

#Preview {
    ContentView()
}
