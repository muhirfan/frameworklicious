//
//  GetTasksIntent.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct GetTasksIntent: AppIntent {
    static var title: LocalizedStringResource = "Get All Tasks"
    static var description = IntentDescription("Returns your current task list.")

    func perform() async throws -> some IntentResult & ReturnsValue<[String]> & ProvidesDialog {
        let tasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
        let message = tasks.isEmpty
            ? "No tasks found."
            : tasks.joined(separator: ", ")

        return .result(
            value: tasks,
            dialog: IntentDialog(stringLiteral: message)
        )
    }
}
