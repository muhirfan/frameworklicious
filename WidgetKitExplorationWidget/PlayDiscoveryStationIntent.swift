//
//  PlayDiscoveryStationIntent.swift
//  WidgetKit Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import AppIntents

@available(iOS 18.0, *)
struct PlayDiscoveryStationIntent: AppIntent {
  //  the title shown in the control gallery
  static var title: LocalizedStringResource = "Play Discovery Station"

  func perform() async throws -> some IntentResult {
    return .result()
  }
}
