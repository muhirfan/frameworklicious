//
//  ColorChoice.swift
//  App Intent Exploration
//
//  Created by Kaushik Manian on 23/4/25.
//

import Foundation
import SwiftUI
import AppIntents   // For AppEnum & CaseDisplayRepresentable


enum ColorChoice: String, AppEnum, CaseDisplayRepresentable {
    case red    = "Red"
    case green  = "Green"
    case blue   = "Blue"
    case yellow = "Yellow"


    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Color")

    // How each case appears (title + emoji) in Siri/Shortcuts
    static var caseDisplayRepresentations: [ColorChoice: DisplayRepresentation] = [
        .red:    DisplayRepresentation(title: "Red",    subtitle: "🔴"),
        .green:  DisplayRepresentation(title: "Green",  subtitle: "🟢"),
        .blue:   DisplayRepresentation(title: "Blue",   subtitle: "🔵"),
        .yellow: DisplayRepresentation(title: "Yellow", subtitle: "🟡")
    ]


    var swiftUIColor: Color {
        switch self {
        case .red:    return .red
        case .green:  return .green
        case .blue:   return .blue
        case .yellow: return .yellow
        }
    }
}
