//
//  IntentProvider.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct IntentProvider: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddTaskIntent(),
            phrases: ["Add a new task"],
            shortTitle: "Add Task",
            systemImageName: "plus.app.fill"
        )
        AppShortcut(
            intent: GetTasksIntent(),
            phrases: ["Show my tasks"],
            shortTitle: "Get Tasks",
            systemImageName: "list.bullet"
        )
    }
}
