//
//  ContentView.swift
//  CloudKit Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var mgr = CloudKitManager.shared
    @State private var newTitle = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Input bar
                HStack {
                    TextField("New task…", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        add()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(newTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding(.horizontal)

                // To-Do list
                List {
                    ForEach(mgr.items) { item in
                        HStack {
                            Button {
                                mgr.toggle(item: item)
                            } label: {
                                Image(systemName:
                                    item.isComplete == 1
                                    ? "checkmark.circle.fill"
                                    : "circle")
                            }
                            Text(item.title)
                                .strikethrough(item.isComplete == 1)
                            Spacer()
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("CloudKit To-Do")
            .toolbar {
                Button("Refresh") { mgr.fetchItems() }
            }
        }
        .onAppear { mgr.fetchItems() }
    }

    private func add() {
        let title = newTitle.trimmingCharacters(in: .whitespaces)
        mgr.addItem(title: title)
        newTitle = ""
    }

    private func delete(at offsets: IndexSet) {
        offsets.map { mgr.items[$0] }.forEach(mgr.delete)
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
