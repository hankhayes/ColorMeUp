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
    
    // Environment
    @Environment(\.self) var environment
    
    // Variables
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
    
    // Input: a hex value, such as #ffffff
    // Output: the color as a Color object
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
    
    // Input: a hex value, such as #ffffff
    // Output: the most accurate name for that color, such as "White"
    func getName(hex: String) -> String {
        let result = jsContext.evaluateScript("ntc.name('#\(hex)')")
        
        if let name = result!.toArray()?[1] as? String {
            return name
        } else {
            return "no name"
        }
    }
    
    // Input: a hex value, such as #00ff00
    // Output: the most accurate category for that color, such as "green"
    func getCategory(hex: String) -> String {
        var lowest = ("", 1000.0)
        
        let categories = [
            ("red", (255, 0, 0)),
            ("orange", (255, 165, 0)),
            ("yellow", (255, 255, 0)),
            ("green", (0, 255, 0)),
            ("blue", (0, 0, 255)),
            ("purple", (255, 0, 255)),
            ("pink", (255, 192, 203))
        ]
        
        let rgb = get8bitRGB(hex: hex)
        
        if (rgb.0 == rgb.1) && (rgb.1 == rgb.2) {
            return "gray"
        }
        
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
    
    // Input: a hex value, such as #ffffff
    // Output: the rgb color channels - (red: 255, green: 255, blue: 255)
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
    
    // Input: a hex value, such as #ffffff
    // Output: floating point rgb channels - (red: 1.0, blue: 1.0, green: 1.0)
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
    
    // Input: a Color object
    // Output: a hex value
    func getHex(color: Color) -> String {
        let components = color.resolve(in: environment)
        let fullHex = components.description
        let hex = fullHex[fullHex.index(fullHex.startIndex, offsetBy: 1)..<fullHex.index(fullHex.startIndex, offsetBy: 7)]
        
        return String(hex)
    }
    
    // Input: a floating point color channel - red: 1.0
    // Output: a linear value
    // Used in the getLuminance function
    func sRGBToLinear(srgb: Double) -> Double {
        if srgb <= 0.04045 {
            return srgb / 12.92
        } else {
            return pow(((srgb + 0.055) / 1.055), 2.4)
        }
    }
    
    // Input: a hex value, such as #ffffff
    // Output: a value that represents the linear measure of lightness of that color. This value is not adjusted for our non linear perception of lightness
    func getLuminance(hex: String) -> Double {
        let backgroundColor = self.getFloatRGB(hex: hex)
        let luminance = (0.2126 * sRGBToLinear(srgb: backgroundColor.0)) + (0.7152 * sRGBToLinear(srgb: backgroundColor.1)) + (0.0722 * sRGBToLinear(srgb: backgroundColor.2))
        return luminance
    }

    // Input: a color's luminance value
    // Output: a Luma value which more accurately represents a color's non-linear perceived lightness
    func LuminancetoLuma(y: Double) -> Double {
        if (y <= (216 / 24389)) {
            return y * ( 24389 / 27)
        } else {
            return pow(y, (1/3)) * 116 - 16
        }
    }
    
    // Input: a hex value, such as #ffffff
    // Output: A boolean that will be false if the Luma value is > 50, meaning the color is above the threshold (lighter). A lower Luma means the color is below the threshold (darker)
    // We will use black text on the lighter colors and white text on the darker colors
    func getTextColor(hex: String) -> Bool {
        let luminance = getLuminance(hex: hex)
        return LuminancetoLuma(y: luminance) > 50 ? false : true
    }
}
