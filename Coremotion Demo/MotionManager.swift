//
//  MotionManager.swift
//  Coremotion Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import CoreMotion
import Combine

// Generic DataPoint for charting
public typealias DataPoint = (timestamp: Date, value: Double)

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private let pedometer = CMPedometer()
    private let altimeter = CMAltimeter()
    
    // Latest readings
    @Published var accelData: CMAccelerometerData?
    @Published var gyroData: CMGyroData?
    @Published var deviceMotion: CMDeviceMotion?
    @Published var magData: CMMagnetometerData?
    @Published var steps: Int = 0
    @Published var altitude: Double = 0.0
    @Published var pressure: Double = 0.0
    
    // Historical data for charts
    @Published var accelXHistory: [DataPoint] = []
    @Published var accelYHistory: [DataPoint] = []
    @Published var accelZHistory: [DataPoint] = []
    @Published var gyroXHistory: [DataPoint] = []
    @Published var gyroYHistory: [DataPoint] = []
    @Published var gyroZHistory: [DataPoint] = []
    @Published var magXHistory: [DataPoint] = []
    @Published var magYHistory: [DataPoint] = []
    @Published var magZHistory: [DataPoint] = []
    @Published var rollHistory: [DataPoint] = []
    @Published var pitchHistory: [DataPoint] = []
    @Published var yawHistory: [DataPoint] = []
    @Published var altitudeHistory: [DataPoint] = []
    @Published var pressureHistory: [DataPoint] = []
    
    private let maxSamples = 50
    
    func startAll() {
        startAccelerometer()
        startGyro()
        startDeviceMotion()
        startMagnetometer()
        startPedometer()
        startAltimeter()
    }
    
    func startAccelerometer() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
            guard let self = self, let data = data else { return }
            let now = Date()
            self.accelData = data
            self.accelXHistory.append((now, data.acceleration.x))
            self.accelYHistory.append((now, data.acceleration.y))
            self.accelZHistory.append((now, data.acceleration.z))
            self.trim(&self.accelXHistory)
            self.trim(&self.accelYHistory)
            self.trim(&self.accelZHistory)
        }
    }
    
    func startGyro() {
        guard motionManager.isGyroAvailable else { return }
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: .main) { [weak self] data, _ in
            guard let self = self, let data = data else { return }
            let now = Date()
            self.gyroData = data
            self.gyroXHistory.append((now, data.rotationRate.x))
            self.gyroYHistory.append((now, data.rotationRate.y))
            self.gyroZHistory.append((now, data.rotationRate.z))
            self.trim(&self.gyroXHistory)
            self.trim(&self.gyroYHistory)
            self.trim(&self.gyroZHistory)
        }
    }
    
    func startDeviceMotion() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self = self, let motion = motion else { return }
            let now = Date()
            self.deviceMotion = motion
            // Convert from radians to degrees for clarity
            let rollDeg = motion.attitude.roll * 180 / .pi
            let pitchDeg = motion.attitude.pitch * 180 / .pi
            let yawDeg = motion.attitude.yaw * 180 / .pi
            self.rollHistory.append((now, rollDeg))
            self.pitchHistory.append((now, pitchDeg))
            self.yawHistory.append((now, yawDeg))
            self.trim(&self.rollHistory)
            self.trim(&self.pitchHistory)
            self.trim(&self.yawHistory)
        }
    }
    
    func startMagnetometer() {
        guard motionManager.isMagnetometerAvailable else { return }
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates(to: .main) { [weak self] data, _ in
            guard let self = self, let data = data else { return }
            let now = Date()
            self.magData = data
            self.magXHistory.append((now, data.magneticField.x))
            self.magYHistory.append((now, data.magneticField.y))
            self.magZHistory.append((now, data.magneticField.z))
            self.trim(&self.magXHistory)
            self.trim(&self.magYHistory)
            self.trim(&self.magZHistory)
        }
    }
    
    func startPedometer() {
        guard CMPedometer.isStepCountingAvailable() else { return }
        pedometer.startUpdates(from: Date()) { [weak self] data, _ in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
                self.steps = data.numberOfSteps.intValue
            }
        }
    }
    
    func startAltimeter() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else { return }
        altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, _ in
            guard let self = self, let data = data else { return }
            let now = Date()
            self.altitude = data.relativeAltitude.doubleValue
            self.pressure = data.pressure.doubleValue
            self.altitudeHistory.append((now, self.altitude))
            self.pressureHistory.append((now, self.pressure))
            self.trim(&self.altitudeHistory)
            self.trim(&self.pressureHistory)
        }
    }
    
    func stopAll() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopMagnetometerUpdates()
        pedometer.stopUpdates()
        altimeter.stopRelativeAltitudeUpdates()
    }
    
    private func trim(_ array: inout [DataPoint]) {
        if array.count > maxSamples {
            array.removeFirst(array.count - maxSamples)
        }
    }
}
