//
//  Shortcuts_ExplorationApp.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import SwiftUI
import SwiftData

@main
struct Shortcuts_ExplorationApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
