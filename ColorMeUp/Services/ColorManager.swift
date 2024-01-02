//
//  ColorManager.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/1/24.
//

import Foundation
import JavaScriptCore
import SwiftUI

struct ColorManager {
    
    @Environment(\.self) var environment
    var jsContext: JSContext!
    
    init() {
        jsContext = JSContext()
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
    
    func getColor(hex: String) -> Color? {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        return Color(red: red, green: green, blue: blue)
    }
    
    func getName(hex: String) -> String {
        let result = jsContext.evaluateScript("ntc.name('#\(hex)')")
        
        if let name = result!.toArray()?[1] as? String {
            return name
        } else {
            return "no name"
        }
    }
    
    func getCategory(hex: String) -> String {
        var lowest = ("", 1000.0)
        
        let categories = [
            ("red", (255, 0, 0)),
            ("orange", (255, 165, 0)),
            ("yellow", (255, 255, 0)),
            ("green", (0, 255, 0)),
            ("blue", (0, 0, 255)),
            ("purple", (255, 0, 255))
        ]
        
        let rgb = get8bitRGB(hex: hex)
        
        for category in categories {
            let redDiff = Double(category.1.0 - rgb.0)
            let greenDiff = Double(category.1.1 - rgb.1)
            let blueDiff = Double(category.1.2 - rgb.2)
            
            let distance = sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff)
            
            if distance < lowest.1 {
                lowest = (category.0, distance)
            }
        }
        
        return lowest.0
    }
    
    func get8bitRGB(hex: String) -> (Int, Int, Int) {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Int((rgb & 0xFF0000) >> 16)
        let green = Int((rgb & 0x00FF00) >> 8)
        let blue = Int(rgb & 0x0000FF)
        
        return (red, green, blue)
    }
    
    func getFloatRGB(hex: String) -> (Double, Double, Double) {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        return (red, blue, green)
    }
    
    func getHex(color: Color) -> String {
        let components = color.resolve(in: environment)
        let fullHex = components.description
        let hex = fullHex[fullHex.index(fullHex.startIndex, offsetBy: 1)..<fullHex.index(fullHex.startIndex, offsetBy: 7)]
        
        return String(hex)
    }
    
    func getTextColor(hex: String) -> Bool {
        let backgroundColor = self.getFloatRGB(hex: hex)
        let luminance = (0.2126 * sRGBToLinear(srgb: backgroundColor.0)) + (0.7152 * sRGBToLinear(srgb: backgroundColor.1)) + (0.0722 * sRGBToLinear(srgb: backgroundColor.2))
        return luminance > 0.5 ? false : true
    }
    
    func sRGBToLinear(srgb: Double) -> Double {
        if srgb <= 0.04045 {
            return srgb / 12.92
        } else {
            return pow(((srgb + 0.055) / 1.055), 2.4)
        }
    }
}
