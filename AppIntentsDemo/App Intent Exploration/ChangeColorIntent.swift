//
//  ChangeColorIntent.swift
//  App Intent Exploration
//
//  Created by Kaushik Manian on 23/4/25.
//

import Foundation
import AppIntents

@available(iOS 17.0, *)
struct ChangeColorIntent: AppIntent {
  static var title: LocalizedStringResource = "Change Background Color"
  static var openAppWhenRun: Bool = true

  @Parameter(title: "Color")
  var color: ColorChoice

  static var parameterSummary: some ParameterSummary {
    Summary("Change background color to \(\.$color)")
  }

  func perform() async throws -> some IntentResult & ReturnsValue<String> {
    let name = color.rawValue
    UserDefaults.standard.set(name, forKey: "selectedColor")
    return .result(value: name)
  }
}
