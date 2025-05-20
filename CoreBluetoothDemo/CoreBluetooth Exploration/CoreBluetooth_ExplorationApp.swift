//
//  CoreBluetooth_ExplorationApp.swift
//  CoreBluetooth Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import SwiftData

@main
struct CoreBluetooth_ExplorationApp: App {
    @StateObject private var bluetoothManager = BluetoothManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bluetoothManager)
        }
    }
}
