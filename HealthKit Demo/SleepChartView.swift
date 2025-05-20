//
//  SleepChartView.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import SwiftUI
import Charts

struct SleepChartView: View {
    let data: [HealthMetric]
    var body: some View {
        Chart(data) { point in
            BarMark(
                x: .value("Day", point.date, unit: .day),
                y: .value("Hours", point.value)
            )
        }
        .frame(height: 200)
        .chartXAxisLabel("Last 7 Days")
        .chartYAxisLabel("Sleep (hrs)")
    }
}
