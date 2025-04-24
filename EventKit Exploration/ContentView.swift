//
//  ContentView.swift
//  EventKit Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import EventKit
import EventKitUI

struct ContentView: View {
    @StateObject private var manager = EventManager()
    @State private var newEvent: EKEvent?
    @State private var showingEditor = false

    var body: some View {
        NavigationStack {
            List {
                if manager.events.isEmpty {
                    Text("No events found in the next 30 days.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(manager.events, id: \.eventIdentifier) { event in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.headline)
                            Text(event.startDate, style: .date)
                            + Text(" at ")
                            + Text(event.startDate, style: .time)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("My Calendar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newEvent = manager.makeNewEvent()
                        showingEditor = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .help("Add a new event")
                }
            }
            .onAppear {
                manager.requestAccess()
            }
            .sheet(isPresented: $showingEditor) {
                if let event = newEvent {
                    EventEditWrapper(
                        store: manager.eventStore,
                        event: event
                    ) {
                        manager.loadEvents()
                    }
                }
            }
        }
    }
}

final class EventManager: ObservableObject {
    let eventStore = EKEventStore()
    @Published var events: [EKEvent] = []

    /// Ask for calendar permission, load events on success
    func requestAccess() {
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents { granted, error in
                DispatchQueue.main.async {
                    if granted { self.loadEvents() }
                    else { print("Access denied:", error?.localizedDescription ?? "-") }
                }
            }
        } else {
            eventStore.requestAccess(to: .event) { granted, error in
                DispatchQueue.main.async {
                    if granted { self.loadEvents() }
                    else { print("Access denied:", error?.localizedDescription ?? "-") }
                }
            }
        }
    }

    /// Fetch ±30 days of events
    func loadEvents() {
        let start = Date().addingTimeInterval(-30*24*3600)
        let end   = Date().addingTimeInterval( 30*24*3600)
        let pred  = eventStore.predicateForEvents(
            withStart: start,
            end:   end,
            calendars: nil
        )
        let found = eventStore.events(matching: pred)
        DispatchQueue.main.async {
            self.events = found.sorted { $0.startDate < $1.startDate }
        }
    }

    /// Build a brand-new event with valid defaults
    func makeNewEvent() -> EKEvent {
        let ev = EKEvent(eventStore: eventStore)
        ev.title     = "Added from app"
        ev.startDate = Date()
        ev.endDate   = ev.startDate.addingTimeInterval(60*60)   // +1 hr
        ev.calendar  = eventStore.defaultCalendarForNewEvents      // required
        return ev
    }
}

// SwiftUI wrapper around EKEventEditViewController
struct EventEditWrapper: UIViewControllerRepresentable {
    let store: EKEventStore
    let event: EKEvent
    var onDismiss: () -> Void

    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let vc = EKEventEditViewController()
        vc.eventStore       = store
        vc.event            = event
        vc.editViewDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(
        _ uiViewController: EKEventEditViewController,
        context: Context
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, EKEventEditViewDelegate {
        let parent: EventEditWrapper
        init(parent: EventEditWrapper) { self.parent = parent }

        func eventEditViewController(
            _ controller: EKEventEditViewController,
            didCompleteWith action: EKEventEditViewAction
        ) {
            controller.dismiss(animated: true) {
                self.parent.onDismiss()
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
