//
//  ContentView.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import SwiftData
import Charts

struct ContentView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager

    var body: some View {
        Group {
            if healthKitManager.isAuthorized {
                DashboardView()
            } else {
                VStack(spacing: 24) {
                    Text("HealthKit Demo")
                        .font(.largeTitle).bold()
                    Button("Grant Access") {
                        healthKitManager.requestAuthorization()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .onAppear { healthKitManager.fetchAllMetrics() }
        .onChange(of: healthKitManager.isAuthorized) { if $0 { healthKitManager.fetchAllMetrics() }}
    }
}
