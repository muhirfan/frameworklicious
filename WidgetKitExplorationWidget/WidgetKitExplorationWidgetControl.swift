//
//  WidgetKitExplorationWidgetControl.swift
//  WidgetKitExplorationWidget
//
//  Created by Kaushik Manian on 24/4/25.
//

import WidgetKit
import SwiftUI
import AppIntents

@available(iOSApplicationExtension 18.0, *)
struct PlayDiscoveryStationControl: ControlWidget {
  var body: some ControlWidgetConfiguration {
    StaticControlConfiguration(kind: "com.yourdomain.playDiscoveryStation") {
      // — apply the tint on the button itself —
      ControlWidgetButton(action: PlayDiscoveryStationIntent()) {
        Label("Play Music", systemImage: "play.fill")
      }
      .tint(.purple)    
    }
    .displayName("Play Music")
    .description("Start your favorite station")
  }
}
