//
//  ContentView.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import SwiftUI
import AppIntents

struct ContentView: View {
    @State private var tasks: [String] = []
    @State private var newTitle: String = ""
    @State private var status: String = "Tap “Add” or ask Siri"

    var body: some View {
        VStack(spacing: 20) {
            TextField("New task", text: $newTitle)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            HStack(spacing: 15) {
                Button("Add") { performAdd() }
                    .buttonStyle(.borderedProminent)

                Button("Clear All") { performClearAll() }
                    .buttonStyle(.bordered)
            }

            Text(status)
                .font(.caption)
                .foregroundColor(.secondary)

            List(tasks, id: \.self) { t in
                Text(t)
            }
        }
        .padding()
        .onAppear(perform: loadTasks)
        .onChange(of: UIApplication.shared.applicationState) { _ in
            loadTasks()
            status = "Tap “Add” or place in shortcuts"
        }
        .onReceive(
            NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
        ) { _ in
            loadTasks()
        }
    }

    private func loadTasks() {
        tasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
    }

    private func performAdd() {
        guard !newTitle.isEmpty else { return }
        let intent = AddTaskIntent()
        intent.title = newTitle

        Task {
            do {
                let res = try await intent.perform()
                status = "Added: \(res.value ?? newTitle)"
                newTitle = ""
                // loadTasks() runs automatically via onReceive
            } catch {
                status = "Error: \(error.localizedDescription)"
            }
        }
    }

    private func performClearAll() {
        let intent = ClearTasksIntent()

        Task {
            do {
                _ = try await intent.perform()
                status = "All tasks cleared"
                newTitle = ""
                // loadTasks() runs automatically via onReceive
            } catch {
                status = "Error: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
