//
//  DashboardView.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import SwiftUI
import Charts

import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager

    let columns = [GridItem(.adaptive(minimum: 200), spacing: 24)]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                // Title
                Text("Health Dashboard")
                    .font(.system(size: 42, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .padding(.horizontal)

                // VisionOS‑style cards
                LazyVGrid(columns: columns, spacing: 24) {
                    VisionCard(title: "Heart Rate\n(Last 12 Hours)") {
                        HeartRateChartView(data: healthKitManager.heartRateData)
                    }
                    VisionCard(title: "Steps\n(Last 7 Days)") {
                        StepsChartView(data: healthKitManager.stepsData)
                    }
                    VisionCard(title: "Sleep\n(Last 7 Days)") {
                        SleepChartView(data: healthKitManager.sleepData)
                    }
                    VisionCard(title: "Active Energy\n(kcal)") {
                        EnergyChartView(data: healthKitManager.energyData)
                    }
                    VisionCard(title: "Distance\n(m)") {
                        DistanceChartView(data: healthKitManager.distanceData)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("BackgroundStart"), Color("BackgroundEnd")]),
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

// A VisionOS‑style card with translucency, hover lift, and depth
struct VisionCard<Content: View>: View {
    let title: String
    let content: Content
    @State private var isHovered: Bool = false

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)

            content
                .frame(height: 200)
                .frame(maxWidth: .infinity)
        }
        .padding(20)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(isHovered ? 0.2 : 0.1),
                radius: isHovered ? 20 : 10,
                x: 0, y: isHovered ? 10 : 5)
        .scaleEffect(isHovered ? 1.04 : 1)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
