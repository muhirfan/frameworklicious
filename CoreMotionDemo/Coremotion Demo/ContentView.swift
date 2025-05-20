//
//  ContentView.swift
//  Coremotion Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import SwiftUI
import Charts

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ChartSection(title: "Accelerometer (m/s²)", xHist: motion.accelXHistory, yHist: motion.accelYHistory, zHist: motion.accelZHistory)
                    ChartSection(title: "Gyroscope (rad/s)", xHist: motion.gyroXHistory, yHist: motion.gyroYHistory, zHist: motion.gyroZHistory)
                    ChartSection(title: "Magnetometer (µT)", xHist: motion.magXHistory, yHist: motion.magYHistory, zHist: motion.magZHistory)
                    AttitudeSection(rollHist: motion.rollHistory, pitchHist: motion.pitchHistory, yawHist: motion.yawHistory)
                    SingleLineChart(title: "Altitude (m)", data: motion.altitudeHistory)
                    SingleLineChart(title: "Pressure (kPa)", data: motion.pressureHistory)
                    StepsView(steps: motion.steps)
                }
                .padding()
            }
            .navigationTitle("CoreMotion Charts")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Start") { motion.startAll() }
                    Button("Stop") { motion.stopAll() }
                }
            }
        }
    }
}

// Reusable chart view for XYZ data
struct ChartSection: View {
    var title: String
    var xHist, yHist, zHist: [DataPoint]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            Text("Units: parsec...") // placeholder for demonstration
                .font(.subheadline).foregroundStyle(.secondary)
            Chart {
                ForEach(xHist, id: \.timestamp) { point in
                    LineMark(x: .value("Time", point.timestamp), y: .value("X", point.value))
                }
                ForEach(yHist, id: \.timestamp) { point in
                    LineMark(x: .value("Time", point.timestamp), y: .value("Y", point.value))
                }
                ForEach(zHist, id: \.timestamp) { point in
                    LineMark(x: .value("Time", point.timestamp), y: .value("Z", point.value))
                }
            }
            .chartXAxis(.hidden)
            .frame(height: 150)
        }
    }
}

// Chart for roll/pitch/yaw
struct AttitudeSection: View {
    var rollHist, pitchHist, yawHist: [DataPoint]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Device Attitude (°)").font(.headline)
            Text("Units: degrees").font(.subheadline).foregroundStyle(.secondary)
            Chart {
                ForEach(rollHist, id: \.timestamp) { pt in
                    LineMark(x: .value("Time", pt.timestamp), y: .value("Roll", pt.value))
                }
                ForEach(pitchHist, id: \.timestamp) { pt in
                    LineMark(x: .value("Time", pt.timestamp), y: .value("Pitch", pt.value))
                }
                ForEach(yawHist, id: \.timestamp) { pt in
                    LineMark(x: .value("Time", pt.timestamp), y: .value("Yaw", pt.value))
                }
            }
            .chartXAxis(.hidden)
            .frame(height: 150)
        }
    }
}

// Single line chart view
struct SingleLineChart: View {
    var title: String
    var data: [DataPoint]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            Text("Units: \(title.components(separatedBy: "(").last?.dropLast() ?? "")")
                .font(.subheadline).foregroundStyle(.secondary)
            Chart(data, id: \.timestamp) { pt in
                LineMark(x: .value("Time", pt.timestamp), y: .value(title, pt.value))
            }
            .chartXAxis(.hidden)
            .frame(height: 150)
        }
    }
}

// Steps view
struct StepsView: View {
    var steps: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text("Steps Taken").font(.headline)
            Text("\(steps) steps").font(.largeTitle)
        }
        .padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
