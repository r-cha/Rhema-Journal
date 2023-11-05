//
//  Item.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/5/23.
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
