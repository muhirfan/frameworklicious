//
//  Item.swift
//  CoreML Demo V2
//
//  Created by Kaushik Manian on 2/5/25.
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
