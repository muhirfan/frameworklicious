//
//  ContentView.swift
//  CoreBluetooth Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Bluetooth power state
                Text("Bluetooth: \(bluetoothManager.bluetoothState.description)")
                    .font(.headline)

                // Central controls
                HStack {
                    Button("Start Scan") {
                        bluetoothManager.startScanning()
                    }
                    .disabled(bluetoothManager.bluetoothState != .poweredOn)

                    Button("Stop Scan") {
                        bluetoothManager.stopScanning()
                    }
                    .disabled(bluetoothManager.bluetoothState != .poweredOn)
                }

                // List discovered devices
                List(bluetoothManager.discoveredDevices) { device in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(device.name)
                                .font(.body)
                            Text("RSSI: \(device.rssi)")
                                .font(.caption)
                        }
                        Spacer()
                        Button("Connect") {
                            bluetoothManager.connect(to: device)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .frame(maxHeight: 200)

                Divider()

                // Peripheral controls
                Toggle("Advertising Peripheral", isOn: $bluetoothManager.isAdvertising)
                       .disabled(bluetoothManager.bluetoothState != .poweredOn)
                       .onChange(of: bluetoothManager.isAdvertising) { oldValue, newValue in
                           if newValue {
                               bluetoothManager.startAdvertising()
                           } else {
                               bluetoothManager.stopAdvertising()
                           }
                       }

                Text(bluetoothManager.isAdvertising
                     ? "Now Advertising Service"
                     : "Not Advertising")
                    .font(.subheadline)

                Spacer()
            }
            .padding()
            .navigationTitle("CoreBluetooth Demo")
        }
    }
}

extension CBManagerState {
    var description: String {
        switch self {
        case .unknown:      return "Unknown"
        case .resetting:    return "Resetting"
        case .unsupported:  return "Unsupported"
        case .unauthorized: return "Unauthorized"
        case .poweredOff:   return "Off"
        case .poweredOn:    return "On"
        @unknown default:   return "Other"
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
