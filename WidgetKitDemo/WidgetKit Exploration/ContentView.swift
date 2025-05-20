//
// ContentView.swift
// WidgetKit Exploration
//
// Simplified to just a quote picker driving the widget.
// Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import WidgetKit

// 1) Same set of quotes your widget shows
fileprivate let sampleQuotes = [
  "Stay hungry, stay foolish.",
  "The only limit to our tomorrow is our doubts of today.",
  "Innovation distinguishes between a leader and a follower.",
  "Code is like humor. When you have to explain it, it’s bad."
]

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List {
        QuotePickerSection()
      }
      .navigationTitle("Pick a Quote")
    }
  }
}

// MARK: – The picker section

private struct QuotePickerSection: View {
  // 2) Use @AppStorage in your app, pointed at the same App Group
  @AppStorage(
    "selectedQuoteIndex",
    store: UserDefaults(suiteName: "group.com.yourdomain.widgetkitexploration")
  ) private var selectedQuoteIndex = 0

  var body: some View {
    Section("Tap a Quote to Update Widget") {
      ForEach(sampleQuotes.indices, id: \.self) { i in
        QuoteRow(
          text: sampleQuotes[i],
          isSelected: (i == selectedQuoteIndex)
        ) {
          // 3) On tap: write the new index, then reload the widget
          selectedQuoteIndex = i
          WidgetCenter.shared.reloadTimelines(ofKind: "WidgetKitExplorationWidget")
        }
      }
    }
  }
}

// MARK: – A single row in our picker

private struct QuoteRow: View {
  let text: String
  let isSelected: Bool
  let onSelect: () -> Void

  var body: some View {
    Button(action: onSelect) {
      HStack {
        Text(text)
          .lineLimit(1)
        Spacer()
        if isSelected {
          Image(systemName: "checkmark")
        }
      }
      .padding(.vertical, 4)
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

// MARK: – Preview

#Preview {
  ContentView()
}
