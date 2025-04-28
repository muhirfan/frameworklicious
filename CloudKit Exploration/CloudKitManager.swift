//
//  CloudKitManager.swift
//  CloudKit Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import CloudKit
import Combine

/// Manages ToDoItem records in CloudKit.
final class CloudKitManager: ObservableObject {
    static let shared = CloudKitManager()
    private let db = CKContainer.default().privateCloudDatabase

    @Published private(set) var items: [ToDoItem] = []

    private init() { }

    /// Fetch
    func fetchItems() {
        let query = CKQuery(recordType: "ToDoItem",
                            predicate: NSPredicate(value: true))
        var fetched: [ToDoItem] = []

        let op = CKQueryOperation(query: query)
        op.resultsLimit = CKQueryOperation.maximumResults

        op.recordMatchedBlock = { recordID, result in
            switch result {
            case .success(let record):
                fetched.append(ToDoItem(record: record))
            case .failure(let error):
                print("CloudKit record match error for \(recordID):", error)
            }
        }

        op.queryResultBlock = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.items = fetched
                case .failure(let error):
                    print("CloudKit fetch error:", error)
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
        db.save(record) { rec, err in
            DispatchQueue.main.async {
                if let rec = rec {
                    self.items.append(ToDoItem(record: rec))
                } else {
                    print("CloudKit save error:", err ?? "none")
                }
            }
        }
    }

    /// Toggle the isComplete
    func toggle(item: ToDoItem) {
        let newValue = item.isComplete == 0 ? 1 : 0
        item.record["isComplete"] = newValue as NSNumber
        db.save(item.record) { rec, err in
            DispatchQueue.main.async {
                if let rec = rec,
                   let idx = self.items.firstIndex(where: { $0.id == item.id }) {
                    self.items[idx] = ToDoItem(record: rec)
                } else {
                    print("CloudKit update error:", err ?? "none")
                }
            }
        }
    }

    /// Delete
    func delete(item: ToDoItem) {
        db.delete(withRecordID: item.record.recordID) { recID, err in
            DispatchQueue.main.async {
                if recID != nil {
                    self.items.removeAll { $0.id == item.id }
                } else {
                    print("CloudKit delete error:", err ?? "none")
                }
            }
        }
    }
}
