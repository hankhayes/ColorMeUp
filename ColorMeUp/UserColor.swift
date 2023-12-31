//
//  UserColor.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import Foundation
import SwiftUI
import JavaScriptCore

struct UserColor: Identifiable {
    
    var jsContext: JSContext!
    
    var id = UUID()
    var hex: String
    var date: Date
    var note: String
    
    var name: String {
        return getName()
    }
    
    var category: String {
        return getCategory()
    }
    
    func getCategory() -> String {
        print("category got")
        var lowest = ("", 1000.0)
        
        let categories = [
            ("red", (255, 0, 0)),
            ("orange", (255, 165, 0)),
            ("yellow", (255, 255, 0)),
            ("green", (0, 255, 0)),
            ("blue", (0, 0, 255)),
            ("purple", (255, 0, 255))
        ]
        
        let rgb = getRGBLong()
        
        for category in categories {
            var redDiff = Double(category.1.0 - rgb.0)
            var greenDiff = Double(category.1.1 - rgb.1)
            var blueDiff = Double(category.1.2 - rgb.2)
            
            let distance = sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff)
            
            if distance < lowest.1 {
                lowest = (category.0, distance)
            }
        }
        
        return lowest.0
    }
    
    
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
    
    func getRGB() -> (Double, Double, Double) {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        return (red, green, blue)
    }
    
    func getRGBLong() -> (Int, Int, Int) {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Int((rgb & 0xFF0000) >> 16)
        let green = Int((rgb & 0x00FF00) >> 8)
        let blue = Int(rgb & 0x0000FF)
        
        return (red, green, blue)
    }
    
    
    init(id: UUID = UUID(), hex: String, date: Date, note: String) {
        
        self.id = id
        self.hex = hex
        self.date = date
        self.note = note
        self.jsContext = JSContext()
        
        initializeJS()
    }
    
    func initializeJS() {
        
        if let jsSourcePath = Bundle.main.path(forResource: "jssource", ofType: "js") {
            do {
                // Load its contents to a String variable.
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                // Add the Javascript code that currently exists in the jsSourceContents to the Javascript Runtime through the jsContext object.
                self.jsContext.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getName() -> String {
        
        guard let jsContext = self.jsContext else {
            return "no js"
        }
        
        let result = jsContext.evaluateScript("ntc.name('#\(self.hex)')")
        
        if let name = result!.toArray()?[1] as? String {
            return name
        } else {
            return "no result"
        }
    }
}
