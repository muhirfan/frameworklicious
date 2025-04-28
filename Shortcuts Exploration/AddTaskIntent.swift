//
//  AddTaskIntent.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct AddTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "Add Task to My Tasks"
    static var description = IntentDescription("Adds a new task with the given title.")
    static var openAppWhenRun: Bool = true

    @Parameter(title: "Task Title")
    var title: String

    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        // append into UserDefaults
        var tasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
        tasks.append(title)
        UserDefaults.standard.set(tasks, forKey: "tasks")

        // return with a spoken/display dialog
        return .result(
            value: title,
            dialog: IntentDialog("Added task: \(title)")
        )
    }
}
