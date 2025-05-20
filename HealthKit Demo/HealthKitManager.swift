//
//  HealthKitManager.swift
//  HealthKit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import HealthKit
import Combine

final class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    @Published var isAuthorized: Bool = false
    @Published var stepCount: Double = 0

    /// Request permission to read step count
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data not available on this device.")
            return
        }
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let readTypes: Set<HKObjectType> = [stepType]
        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
            DispatchQueue.main.async {
                self.isAuthorized = success
            }
            if let error = error {
                print("Authorization error: \(error.localizedDescription)")
            }
        }
    }

    /// Fetch today's step count
    func fetchTodayStepCount() {
        guard isAuthorized else { return }
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        let query = HKStatisticsQuery(
            quantityType: stepType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            var total: Double = 0
            if let sum = result?.sumQuantity() {
                total = sum.doubleValue(for: HKUnit.count())
            }
            DispatchQueue.main.async {
                self.stepCount = total
            }
        }
        healthStore.execute(query)
    }
}
