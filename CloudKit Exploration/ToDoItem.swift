//
//  ToDoItem.swift
//  CloudKit Exploration
//
//  Created by Kaushik Manian on 28/4/25.
//

import Foundation
import CloudKit

struct ToDoItem: Identifiable {
    let id: UUID
    var title: String
    var isComplete: Int
    var record: CKRecord
    init(record: CKRecord) {
        self.record = record
        self.id = UUID(uuidString: record.recordID.recordName) ?? UUID()
        self.title = record["title"] as? String ?? ""
        self.isComplete = record["isComplete"] as? Int ?? 0
    }
}
