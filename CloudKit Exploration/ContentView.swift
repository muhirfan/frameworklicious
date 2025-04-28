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

    // For editing existing items via swipe or long-press
    @State private var editingItem: ToDoItem?
    @State private var editedTitle = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    VStack {
                        HStack(spacing: 12) {
                            TextField("New task…", text: $newTitle)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            
                            Button(action: add) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                                    .frame(width: 46, height: 46)
                                    .background(
                                        Circle()
                                            .fill(Color.blue.opacity(0.1))
                                    )
                            }
                            .disabled(newTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    List {
                        ForEach(mgr.items) { item in
                            HStack(spacing: 16) {
                                Button(action: { mgr.toggle(item: item) }) {
                                    Image(systemName:
                                        item.isComplete == 1
                                        ? "checkmark.circle.fill"
                                        : "circle")
                                        .font(.system(size: 22))
                                        .foregroundColor(
                                            item.isComplete == 1 ? .green : .gray
                                        )
                                }
                                
                                Text(item.title)
                                    .font(.system(size: 16))
                                    .strikethrough(item.isComplete == 1)
                                    .foregroundColor(
                                        item.isComplete == 1 ? .gray : .primary
                                    )
                                    .lineLimit(2)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray.opacity(0.5))
                            }
                            .padding(.vertical, 8)
                            .contentShape(Rectangle())
                            .swipeActions(edge: .leading) {
                                Button("Edit") {
                                    editingItem = item
                                    editedTitle = item.title
                                }
                                .tint(.blue)
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.systemBackground))
                                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                    .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                            )
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationTitle("CloudKit To-Do")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: mgr.fetchItems) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 14))
                            Text("Refresh")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.blue)
                    }
                }
            }
            .sheet(item: $editingItem) { item in
                NavigationView {
                    ZStack {
                        Color(.systemGroupedBackground)
                            .ignoresSafeArea()
                        
                        Form {
                            Section {
                                TextField("Title", text: $editedTitle)
                                    .padding(.vertical, 4)
                            } header: {
                                Text("Edit Task")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 4)
                            }
                        }
                    }
                    .navigationTitle("Edit To-Do")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                editingItem = nil
                            }
                            .foregroundColor(.red)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                mgr.update(item: item, newTitle: editedTitle)
                                editingItem = nil
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        }
                    }
                }
                .onAppear {
                    editedTitle = item.title
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
