//
//  UserColor.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import Foundation
import SwiftUI

struct UserColor: Identifiable {
    
    var id = UUID()
    var hex: String
    var date: Date
    var note: String
    var category: String
    
    func getColor() -> Color? {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        return Color(red: red, green: green, blue: blue)
    }
}
