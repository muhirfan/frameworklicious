//
//  BluetoothDevice.swift
//  CoreBluetooth Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import CoreBluetooth

struct BluetoothDevice: Identifiable {
    let id: UUID
    let name: String
    let rssi: Int
    let peripheral: CBPeripheral
}
