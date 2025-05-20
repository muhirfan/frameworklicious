//
//  HealthKitManager.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import HealthKit
import Combine

/// Simple data model for chart points
struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

final class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    @Published var isAuthorized = false
    @Published var stepsData: [HealthMetric] = []
    @Published var heartRateData: [HealthMetric] = []
    @Published var energyData: [HealthMetric] = []
    @Published var distanceData: [HealthMetric] = []
    @Published var sleepData: [HealthMetric] = []

    private let readTypes: Set<HKObjectType>

    private init() {
        let types: [HKObjectType] = [
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]
        readTypes = Set(types)
    }

    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
            DispatchQueue.main.async {
                self.isAuthorized = success
                if success { self.fetchAllMetrics() }
            }
            if let error = error {
                print("Authorization error: \(error.localizedDescription)")
            }
        }
    }

    func fetchAllMetrics() {
        guard isAuthorized else { return }
        fetchStepData()
        fetchHeartRateData()
        fetchEnergyData()
        fetchDistanceData()
        fetchSleepData()
    }

    private func fetchStepData() {
        let type = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let calendar = Calendar.current
        let anchor = calendar.startOfDay(for: now)
        let interval = DateComponents(day: 1)

        let query = HKStatisticsCollectionQuery(
            quantityType: type,
            quantitySamplePredicate: nil,
            options: .cumulativeSum,
            anchorDate: anchor,
            intervalComponents: interval
        )
        query.initialResultsHandler = { _, result, _ in
            var data: [HealthMetric] = []
            let start = calendar.date(byAdding: .day, value: -6, to: anchor)! // last 7 days
            result?.enumerateStatistics(from: start, to: now) { stat, _ in
                let value = stat.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                data.append(.init(date: stat.startDate, value: value))
            }
            DispatchQueue.main.async { self.stepsData = data }
        }
        healthStore.execute(query)
    }

    private func fetchHeartRateData() {
        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let now = Date()
        let start = Calendar.current.date(byAdding: .hour, value: -12, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: start, end: now, options: .strictStartDate)
        let sortDescriptors = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]

        let query = HKSampleQuery(sampleType: type,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: sortDescriptors) { _, samples, error in
            guard error == nil else {
                print("HeartRate fetch error: \(error!.localizedDescription)")
                return
            }
            // Explicitly typed to avoid Any inference
            let data: [HealthMetric] = (samples as? [HKQuantitySample])?.map { sample in
                let bpm = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                return HealthMetric(date: sample.startDate, value: bpm)
            } ?? []
            DispatchQueue.main.async { self.heartRateData = data }
        }
        healthStore.execute(query)
    }


    private func fetchEnergyData() {
        let type = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let now = Date()
        let calendar = Calendar.current
        let anchor = calendar.startOfDay(for: now)
        let interval = DateComponents(day: 1)

        let query = HKStatisticsCollectionQuery(
            quantityType: type,
            quantitySamplePredicate: nil,
            options: .cumulativeSum,
            anchorDate: anchor,
            intervalComponents: interval
        )
        query.initialResultsHandler = { _, result, _ in
            var data: [HealthMetric] = []
            let start = calendar.date(byAdding: .day, value: -6, to: anchor)!
            result?.enumerateStatistics(from: start, to: now) { stat, _ in
                let kcal = stat.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0
                data.append(.init(date: stat.startDate, value: kcal))
            }
            DispatchQueue.main.async { self.energyData = data }
        }
        healthStore.execute(query)
    }

    private func fetchDistanceData() {
        let type = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let now = Date()
        let calendar = Calendar.current
        let anchor = calendar.startOfDay(for: now)
        let interval = DateComponents(day: 1)

        let query = HKStatisticsCollectionQuery(
            quantityType: type,
            quantitySamplePredicate: nil,
            options: .cumulativeSum,
            anchorDate: anchor,
            intervalComponents: interval
        )
        query.initialResultsHandler = { _, result, _ in
            var data: [HealthMetric] = []
            let start = calendar.date(byAdding: .day, value: -6, to: anchor)!
            result?.enumerateStatistics(from: start, to: now) { stat, _ in
                let m = stat.sumQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0
                data.append(.init(date: stat.startDate, value: m))
            }
            DispatchQueue.main.async { self.distanceData = data }
        }
        healthStore.execute(query)
    }

    private func fetchSleepData() {
        let type = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let now = Date()
        let start = Calendar.current.date(byAdding: .day, value: -6, to: Calendar.current.startOfDay(for: now))!
        let pred = HKQuery.predicateForSamples(withStart: start, end: now, options: [])

        let query = HKSampleQuery(sampleType: type, predicate: pred, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, _ in
            var dayTotals: [Date: TimeInterval] = [:]
            (samples as? [HKCategorySample])?.forEach {
                let day = Calendar.current.startOfDay(for: $0.startDate)
                let dur = $0.endDate.timeIntervalSince($0.startDate)
                dayTotals[day, default: 0] += dur
            }
            let data = dayTotals.map { HealthMetric(date: $0.key, value: $0.value / 3600) }
                .sorted { $0.date < $1.date }
            DispatchQueue.main.async { self.sleepData = data }
        }
        healthStore.execute(query)
    }
}
