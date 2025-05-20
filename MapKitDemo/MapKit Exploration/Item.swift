//
//  Item.swift
//  MapKit Exploration
//
//  Created by Kaushik Manian on 29/4/25.
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
