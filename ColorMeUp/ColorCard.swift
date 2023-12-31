//
//  ColorCard.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ColorCard: View {
    
    var color: UserColor
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(color.getColor())
                    .cornerRadius(15)
                VStack(alignment: .leading) {
                    HStack {
                        Text("#\(color.hex)")
                            .font(.subheadline)
                        Spacer()
                        Text(color.note)
                            .font(.subheadline)
                    }
                    .padding()
                    // Spacer()
                    Text(color.name)
                        .font(.title)
                        .padding()
                    // Spacer()
                    HStack {
                        Text("September 10")
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding()
                }
                .foregroundStyle(getTextColor())
            }
        }
    }
    
    func getTextColor() -> Color {
        let backgroundColor = color.getRGB()
        let luminance = (0.2126 * sRGBToLinear(srgb: backgroundColor.0)) + (0.7152 * sRGBToLinear(srgb: backgroundColor.1)) + (0.0722 * sRGBToLinear(srgb: backgroundColor.2))
        return luminance > 0.5 ? Color(.black) : Color(.white)
    }
    
    func sRGBToLinear(srgb: Double) -> Double {
        if srgb <= 0.04045 {
            return srgb / 12.92
        } else {
            return pow(((srgb + 0.055) / 1.055), 2.4)
        }
    }
}

#Preview {
    ColorCard(color: UserColor(hex: "007AFF", date: Date(), note: "Bedroom wall"))
}
