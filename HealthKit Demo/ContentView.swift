//
//  ContentView.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager

    var body: some View {
        VStack(spacing: 24) {
            Text("HealthKit Demo")
                .font(.largeTitle)
                .bold()

            if healthKitManager.isAuthorized {
                Text("Steps today: \(Int(healthKitManager.stepCount))")
                    .font(.title2)

                Button("Refresh Steps") {
                    healthKitManager.fetchTodayStepCount()
                }
                .buttonStyle(.borderedProminent)

            } else {
                Button("Grant HealthKit Access") {
                    healthKitManager.requestAuthorization()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .onAppear {
            if healthKitManager.isAuthorized {
                healthKitManager.fetchTodayStepCount()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
