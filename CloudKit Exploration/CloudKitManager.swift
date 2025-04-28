//
//  CloudKitManager.swift
//  CloudKit Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import CloudKit
import Combine


final class CloudKitManager: ObservableObject {
    static let shared = CloudKitManager()
    private let db = CKContainer.default().privateCloudDatabase

    @Published private(set) var items: [ToDoItem] = []

    private init() {}

    /// Read:
    func fetchItems() {
        let query = CKQuery(recordType: "ToDoItem",
                            predicate: NSPredicate(value: true))
        var fetched: [ToDoItem] = []

        let op = CKQueryOperation(query: query)
        op.resultsLimit = CKQueryOperation.maximumResults

        op.recordMatchedBlock = { _, result in
            if case .success(let record) = result {
                fetched.append(ToDoItem(record: record))
            }
        }

        op.queryResultBlock = { [weak self] result in
            DispatchQueue.main.async {
                if case .success = result {
                    self?.items = fetched
                } else if case .failure(let error) = result {
                    print("❌ fetch error:", error)
                }
            }
        }

        db.add(op)
    }

    /// Create
    func addItem(title: String) {
        let record = CKRecord(recordType: "ToDoItem")
        record["title"] = title as NSString
        record["isComplete"] = 0 as NSNumber

        db.save(record) { [weak self] rec, err in
            DispatchQueue.main.async {
                if let rec = rec {
                    self?.items.append(ToDoItem(record: rec))
                } else {
                    print("❌ save error:", err ?? "unknown")
                }
            }
        }
    }

    /// Update
    func toggle(item: ToDoItem) {
        let newValue = item.isComplete == 0 ? 1 : 0
        item.record["isComplete"] = newValue as NSNumber

        db.save(item.record) { [weak self] rec, err in
            DispatchQueue.main.async {
                if let rec = rec,
                   let idx = self?.items.firstIndex(where: { $0.id == item.id }) {
                    self?.items[idx] = ToDoItem(record: rec)
                } else {
                    print("❌ update error:", err ?? "unknown")
                }
            }
        }
    }

    /// Update
    func update(item: ToDoItem, newTitle: String) {
        item.record["title"] = newTitle as NSString

        db.save(item.record) { [weak self] rec, err in
            DispatchQueue.main.async {
                if let rec = rec,
                   let idx = self?.items.firstIndex(where: { $0.id == item.id }) {
                    self?.items[idx] = ToDoItem(record: rec)
                } else {
                    print("❌ title-edit error:", err ?? "unknown")
                }
            }
        }
    }

    /// Delete
    func delete(item: ToDoItem) {
        db.delete(withRecordID: item.record.recordID) { [weak self] recID, err in
            DispatchQueue.main.async {
                if recID != nil {
                    self?.items.removeAll { $0.id == item.id }
                } else {
                    print("❌ delete error:", err ?? "unknown")
                }
            }
        }
    }
}
