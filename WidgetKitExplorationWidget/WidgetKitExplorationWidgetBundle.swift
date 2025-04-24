//
//  WidgetKitExplorationWidgetBundle.swift
//  WidgetKitExplorationWidget
//
//  Created by Kaushik Manian on 24/4/25.
//

import WidgetKit
import SwiftUI

//@main
//struct WidgetKitExplorationBundle: WidgetBundle {
//  @WidgetBundleBuilder
//  var body: some Widget {
//    WidgetKitExplorationWidget()
//    if #available(iOSApplicationExtension 18.0, *) {
//      PlayDiscoveryStationControl()
//    }
//  }
//}


@main
struct WidgetKitExplorationWidget: Widget {
  let kind: String = "WidgetKitExplorationWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      WidgetKitExplorationWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Quote of the Hour")
    .description("Shows a fresh quote every hour.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

