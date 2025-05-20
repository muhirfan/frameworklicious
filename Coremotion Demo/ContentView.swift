//
//  ContentView.swift
//  Coremotion Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Accelerometer")) {
                    if let data = motion.accelData {
                        Text("x: \(data.acceleration.x, specifier: "%.2f")")
                        Text("y: \(data.acceleration.y, specifier: "%.2f")")
                        Text("z: \(data.acceleration.z, specifier: "%.2f")")
                    } else {
                        Text("No data")
                    }
                }
                Section(header: Text("Gyroscope")) {
                    if let data = motion.gyroData {
                        Text("x: \(data.rotationRate.x, specifier: "%.2f")")
                        Text("y: \(data.rotationRate.y, specifier: "%.2f")")
                        Text("z: \(data.rotationRate.z, specifier: "%.2f")")
                    } else {
                        Text("No data")
                    }
                }
                Section(header: Text("Device Motion")) {
                    if let dm = motion.deviceMotion {
                        Text("Roll: \(dm.attitude.roll, specifier: "%.2f")")
                        Text("Pitch: \(dm.attitude.pitch, specifier: "%.2f")")
                        Text("Yaw: \(dm.attitude.yaw, specifier: "%.2f")")
                    } else {
                        Text("No data")
                    }
                }
                Section(header: Text("Steps")) {
                    Text("\(motion.steps)")
                }
                Section(header: Text("Altitude")) {
                    Text("\(motion.altitude, specifier: "%.2f") m")
                }
            }
            .navigationTitle("CoreMotion Demo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Stop") { motion.stopAll() }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
