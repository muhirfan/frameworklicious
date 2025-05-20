//
//  Item.swift
//  Arkit Demo
//
//  Created by Kaushik Manian on 20/5/25.
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
