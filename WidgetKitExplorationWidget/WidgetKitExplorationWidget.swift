//
//  WidgetKitExplorationWidget.swift
//  WidgetKitExplorationWidget
//
//  Created by Kaushik Manian on 24/4/25.
//

import WidgetKit
import SwiftUI

let sampleQuotes = [
  "Stay hungry, stay foolish.",
  "The only limit to our tomorrow is our doubts of today.",
  "Innovation distinguishes between a leader and a follower.",
  "Code is like humor. When you have to explain it, it’s bad.",
  "In theory, there is no difference between theory and practice."
]

struct SimpleEntry: TimelineEntry {
  let date: Date
}

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    completion(SimpleEntry(date: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
    var entries: [SimpleEntry] = []
    let now = Date()
    // ➋ build 24 hourly entries
    for hourOffset in 0..<24 {
      let entryDate = Calendar.current
        .date(byAdding: .hour, value: hourOffset, to: now)!
      entries.append(SimpleEntry(date: entryDate))
    }
    completion(Timeline(entries: entries, policy: .atEnd))
  }
}

struct WidgetKitExplorationWidgetEntryView: View {
  @Environment(\.widgetFamily) var family
  var entry: Provider.Entry

  var body: some View {
    switch family {
    case .systemSmall:
      VStack(spacing: 8) {
        Text(sampleQuotes.randomElement()!)
          .font(.headline)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 8)
        if #available(iOS 17.0, *) {
          Button("🔄") {
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetKitExplorationWidget")
          }
          .buttonStyle(.plain)
        }
      }

    case .systemMedium:
      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image(systemName: "quote.bubble")
          Text("Quote of the Hour")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        Text(sampleQuotes.randomElement()!)
          .font(.title3)
          .multilineTextAlignment(.leading)
        if #available(iOS 17.0, *) {
          Button("🔄") {
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetKitExplorationWidget")
          }
          .buttonStyle(.plain)
        }
      }
      .padding(12)

    default:
      Text(sampleQuotes.randomElement()!)
    }
  }
}

//@main
//struct WidgetKitExplorationWidget: Widget {
//  let kind: String = "WidgetKitExplorationWidget"
//
//  var body: some WidgetConfiguration {
//    StaticConfiguration(kind: kind, provider: Provider()) { entry in
//      WidgetKitExplorationWidgetEntryView(entry: entry)
//    }
//    .configurationDisplayName("Quote of the Hour")
//    .description("Shows a fresh quote every hour.")
//    .supportedFamilies([.systemSmall, .systemMedium])
//  }
//}
