//
//  HealthKit_DemoApp.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import SwiftData

@main
struct HealthKitDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HealthKitManager.shared)
        }
    }
}
