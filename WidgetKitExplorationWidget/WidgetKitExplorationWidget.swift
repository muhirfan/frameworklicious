//
//  WidgetKitExplorationWidget.swift
//  WidgetKitExplorationWidget
//
//  Created by Kaushik Manian on 24/4/25.
//

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
  "Code is like humor. When you have to explain it, it’s bad."
]

struct SimpleEntry: TimelineEntry {
  let date: Date
}

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry { .init(date: Date()) }
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    completion(.init(date: Date()))
  }
  func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
    let now = Date()
    let entries = (0..<24).map {
      SimpleEntry(date: Calendar.current.date(byAdding: .hour, value: $0, to: now)!)
    }
    completion(.init(entries: entries, policy: .atEnd))
  }
}

struct WidgetKitExplorationWidgetEntryView: View {
  @Environment(\.widgetFamily) var family
  var entry: Provider.Entry

  var body: some View {
    switch family {
      
    // Home‐screen small
    case .systemSmall:
      VStack(spacing: 8) {
        Text(sampleQuotes.randomElement()!)
          .font(.headline)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 8)
        if #available(iOS 17.0, *) {
          Button {
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetKitExplorationWidget")
          } label: {
            Image(systemName: "arrow.clockwise.circle.fill")
          }
          .buttonStyle(.bordered)
        }
      }
      .padding()

    // Home‐screen medium
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
          Button {
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetKitExplorationWidget")
          } label: {
            Image(systemName: "arrow.clockwise")
          }
          .buttonStyle(.bordered)
        }
      }
      .padding(12)

    // Lock‐screen rectangular (below the clock)
    case .accessoryRectangular:
      HStack {
        Image(systemName: "quote.bubble")
        Text(sampleQuotes.randomElement()!)
          .font(.caption2)
      }
      .padding(6)

    // Lock‐screen inline (next to the date)
    case .accessoryInline:
      Text(sampleQuotes.randomElement()!)
        .font(.caption2)

    // Lock‐screen circular (round)
    case .accessoryCircular:
      Text("“”")
        .font(.title3)
        .multilineTextAlignment(.center)

    // Catch any future new families
    @unknown default:
      Text(sampleQuotes.randomElement()!)
        .font(.caption2)
        .multilineTextAlignment(.center)
    }
  }
}

