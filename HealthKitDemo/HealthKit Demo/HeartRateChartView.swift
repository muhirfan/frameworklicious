//
//  HeartRateChartView.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import SwiftUI
import Charts

struct HeartRateChartView: View {
    let data: [HealthMetric]
    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Time", point.date),
                y: .value("BPM", point.value)
            )
        }
        .frame(height: 200)
        .chartXAxisLabel("Last 12 Hours")
        .chartYAxisLabel("Heart Rate (BPM)")
    }
}
