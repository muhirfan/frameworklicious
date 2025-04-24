//
//  BluetoothManager.swift
//  CoreBluetooth Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import CoreBluetooth

final class BluetoothManager: NSObject, ObservableObject {
    @Published var discoveredDevices: [BluetoothDevice] = []
    @Published var isAdvertising    = false
    @Published var bluetoothState: CBManagerState = .unknown

    private var centralManager: CBCentralManager!
    private var peripheralManager: CBPeripheralManager!
    private var transferCharacteristic: CBMutableCharacteristic?

    override init() {
        super.init()
        centralManager    = CBCentralManager(delegate: self, queue: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    // MARK: - Central Role

    func startScanning() {
        discoveredDevices.removeAll()
        centralManager.scanForPeripherals(
            withServices: nil,
            options: [CBCentralManagerScanOptionAllowDuplicatesKey: false]
        )
    }

    func stopScanning() {
        centralManager.stopScan()
    }

    func connect(to device: BluetoothDevice) {
        centralManager.connect(device.peripheral, options: nil)
    }

    // MARK: - Peripheral Role

    func startAdvertising() {
        let serviceUUID = CBUUID(string: "FFE0")
        transferCharacteristic = CBMutableCharacteristic(
            type: CBUUID(string: "FFE1"),
            properties: [.read, .notify],
            value: nil,
            permissions: [.readable]
        )
        let service = CBMutableService(type: serviceUUID, primary: true)
        service.characteristics = [transferCharacteristic!]
        peripheralManager.add(service)
        peripheralManager.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [serviceUUID],
            CBAdvertisementDataLocalNameKey: "DemoPeripheral"
        ])
        isAdvertising = true
    }

    func stopAdvertising() {
        peripheralManager.stopAdvertising()
        isAdvertising = false
    }
}

// MARK: - CBCentralManagerDelegate

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        DispatchQueue.main.async {
            self.bluetoothState = central.state
        }
    }

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        let name = peripheral.name ?? "Unknown"
        let device = BluetoothDevice(
            id: peripheral.identifier,
            name: name,
            rssi: RSSI.intValue,
            peripheral: peripheral
        )
        DispatchQueue.main.async {
            if !self.discoveredDevices.contains(where: { $0.id == device.id }) {
                self.discoveredDevices.append(device)
            }
        }
    }

    func centralManager(
        _ central: CBCentralManager,
        didConnect peripheral: CBPeripheral
    ) {
        // You can call peripheral.discoverServices(...) here
    }
}

// MARK: - CBPeripheralManagerDelegate

extension BluetoothManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ manager: CBPeripheralManager) {
        DispatchQueue.main.async {
            self.bluetoothState = manager.state
        }
    }

    func peripheralManager(
        _ manager: CBPeripheralManager,
        didReceiveRead request: CBATTRequest
    ) {
        guard request.characteristic.uuid == transferCharacteristic?.uuid else {
            manager.respond(to: request, withResult: .requestNotSupported)
            return
        }
        let response = "Hello from Peripheral"
            .data(using: .utf8)!
        request.value = response.subdata(
            in: request.offset..<response.count
        )
        manager.respond(to: request, withResult: .success)
    }
}
