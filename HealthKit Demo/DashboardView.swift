//
//  DashboardView.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Health Dashboard")
                    .font(.largeTitle).bold()
                StepsChartView(data: healthKitManager.stepsData)
                HeartRateChartView(data: healthKitManager.heartRateData)
                EnergyChartView(data: healthKitManager.energyData)
                DistanceChartView(data: healthKitManager.distanceData)
                SleepChartView(data: healthKitManager.sleepData)
            }
            .padding()
        }
    }
}
