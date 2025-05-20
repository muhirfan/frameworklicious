//
//  MotionManager.swift
//  Coremotion Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private let pedometer = CMPedometer()
    private let altimeter = CMAltimeter()
    
    @Published var accelData: CMAccelerometerData?
    @Published var gyroData: CMGyroData?
    @Published var deviceMotion: CMDeviceMotion?
    @Published var steps: Int = 0
    @Published var altitude: Double = 0.0
    
    init() {
        startAccelerometer()
        startGyro()
        startDeviceMotion()
        startPedometer()
        startAltimeter()
    }
    
    func startAccelerometer() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data else { return }
            self.accelData = data
        }
    }
    
    func startGyro() {
        guard motionManager.isGyroAvailable else { return }
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: .main) { data, error in
            guard let data = data else { return }
            self.gyroData = data
        }
    }
    
    func startDeviceMotion() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion else { return }
            self.deviceMotion = motion
        }
    }
    
    func startPedometer() {
        guard CMPedometer.isStepCountingAvailable() else { return }
        pedometer.startUpdates(from: Date()) { data, error in
            guard let data = data else { return }
            DispatchQueue.main.async { self.steps = data.numberOfSteps.intValue }
        }
    }
    
    func startAltimeter() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else { return }
        altimeter.startRelativeAltitudeUpdates(to: .main) { data, error in
            guard let data = data else { return }
            self.altitude = data.relativeAltitude.doubleValue
        }
    }
    
    func stopAll() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopDeviceMotionUpdates()
        pedometer.stopUpdates()
        altimeter.stopRelativeAltitudeUpdates()
    }
}
