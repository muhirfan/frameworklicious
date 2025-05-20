//
//  WidgetKitExplorationWidget.swift
//  WidgetKitExplorationWidget
//
//  Created by Kaushik Manian on 24/4/25.
//
import WidgetKit
import SwiftUI

// same list of quotes
let sampleQuotes = [
  "Stay hungry, stay foolish.",
  "The only limit to our tomorrow is our doubts of today.",
  "Innovation distinguishes between a leader and a follower.",
  "Code is like humor. When you have to explain it, it’s bad."
]

// ➌ include the selected index in your entry
struct SimpleEntry: TimelineEntry {
  let date: Date
  let quoteIndex: Int
}

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    .init(date: Date(), quoteIndex: 0)
  }

  func getSnapshot(in context: Context,
                   completion: @escaping (SimpleEntry) -> Void) {
    let idx = UserDefaults(suiteName: "group.com.yourdomain.widgetkitexploration")?
                .integer(forKey: "selectedQuoteIndex") ?? 0
    completion(.init(date: Date(), quoteIndex: idx))
  }

  func getTimeline(in context: Context,
                   completion: @escaping (Timeline<SimpleEntry>) -> Void) {
    let now = Date()
    let idx = UserDefaults(suiteName: "group.com.yourdomain.widgetkitexploration")?
                .integer(forKey: "selectedQuoteIndex") ?? 0

    // generate 24 hourly entries, all showing the same selected quote
    let entries = (0..<24).map { offset in
      let entryDate = Calendar.current.date(
        byAdding: .hour, value: offset, to: now)!
      return SimpleEntry(date: entryDate, quoteIndex: idx)
    }
    completion(.init(entries: entries, policy: .atEnd))
  }
}

struct WidgetKitExplorationWidgetEntryView: View {
  @Environment(\.widgetFamily) var family
  var entry: Provider.Entry

  var body: some View {
    // pick the quote the user tapped in the app
    let quote = sampleQuotes[entry.quoteIndex]

    switch family {
    case .systemSmall:
      VStack(spacing: 8) {
        Text(quote)
          .font(.headline)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 8)
      }
      .padding()

    case .systemMedium:
      VStack(alignment: .leading, spacing: 8) {
        Text("Quote of the Hour")
          .font(.caption).foregroundColor(.secondary)
        Text(quote)
          .font(.title3)
          .multilineTextAlignment(.leading)
      }
      .padding(12)

    // Lock‐screen below the clock
    case .accessoryRectangular:
      HStack {
        Image(systemName: "quote.bubble")
        Text(quote)
          .font(.caption2)
      }
      .padding(6)

    // Lock‐screen inline
    case .accessoryInline:
      Text(quote)
        .font(.caption2)

    // Lock‐screen circular
    case .accessoryCircular:
      Text("“”")
        .font(.title3)
        .multilineTextAlignment(.center)

    @unknown default:
      Text(quote)
        .font(.caption2)
        .multilineTextAlignment(.center)
    }
  }
}

@main
struct WidgetKitExplorationWidget: Widget {
  let kind: String = "WidgetKitExplorationWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind,
                        provider: Provider()) { entry in
      WidgetKitExplorationWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Quote of the Hour")
    .description("Shows the quote you picked in the app.")
    .supportedFamilies([
      .systemSmall,
      .systemMedium,
      .accessoryCircular,
      .accessoryRectangular,
      .accessoryInline
    ])
  }
}
