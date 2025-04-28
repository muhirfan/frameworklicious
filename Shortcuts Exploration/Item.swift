//
//  Item.swift
//  Shortcuts Exploration
//
//  Created by Kaushik Manian on 28/4/25.
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
