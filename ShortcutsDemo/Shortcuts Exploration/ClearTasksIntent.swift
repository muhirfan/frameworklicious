//
//  ClearTasksIntent.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct ClearTasksIntent: AppIntent {
    static var title: LocalizedStringResource = "Clear All Tasks"
    static var description = IntentDescription("Deletes all tasks from your task list.")
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult & ReturnsValue<Bool> & ProvidesDialog {
        UserDefaults.standard.removeObject(forKey: "tasks")
        return .result(
            value: true,
            dialog: IntentDialog("All tasks have been cleared.")
        )
    }
}
