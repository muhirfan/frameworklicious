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
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        TextField("New task…", text: $newTitle)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                        
                        Button {
                            add()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .fill(Color.blue.opacity(0.1))
                                )
                        }
                        .disabled(newTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                List {
                    ForEach(mgr.items) { item in
                        HStack(spacing: 16) {
                            Button {
                                mgr.toggle(item: item)
                            } label: {
                                Image(systemName: item.isComplete == 1 ? "checkmark.circle.fill" : "circle")
                                    .font(.system(size: 22))
                                    .foregroundColor(item.isComplete == 1 ? .green : .gray)
                            }
                            
                            Text(item.title)
                                .strikethrough(item.isComplete == 1)
                                .foregroundColor(item.isComplete == 1 ? .gray : .primary)
                                .font(.system(size: 16))
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                        )
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
                .background(Color(.systemGroupedBackground))
            }
            .navigationTitle("CloudKit To-Do")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button {
                    mgr.fetchItems()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.clockwise")
                        Text("Refresh")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(.blue)
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

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
