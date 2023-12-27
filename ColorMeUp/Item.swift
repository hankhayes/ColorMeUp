//
//  Item.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
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
