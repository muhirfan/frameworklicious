//
//  IntentProvider.swift
//  App Intent Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct IntentProvider: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        // no `[...]` here — just list your shortcuts
        AppShortcut(
            intent: ChangeColorIntent(),
            phrases: [
                "Change background color to red",
                "Change background color to green",
                "Change background color to blue",
                "Change background color to yellow"
            ]
        )
    }
}
