//
//  Item.swift
//  App Intent Exploration
//
//  Created by Kaushik Manian on 23/4/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
