//
//  UserColor.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/1/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class UserColor: Identifiable {
    
    var id = UUID()
    var name: String
    var hex: String
    var category: String
    var date: Date
    var note: String
    var whiteText: Bool
    
    init(name: String, hex: String, category: String, date: Date, note: String, whiteText: Bool) {
        self.name = name
        self.hex = hex
        self.category = category
        self.date = date
        self.note = note
        self.whiteText = whiteText
    }
}
