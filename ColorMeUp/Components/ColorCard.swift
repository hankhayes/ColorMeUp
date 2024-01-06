//
//  ColorCard.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ColorCard: View {
    
    // ColorManager is a custom class that makes a variety of calculations relating to the UserColor class
    var colorManager = ColorManager()
    
    // Struct arguments
    var color: UserColor
    
    // Variables
    var textColor: Color {
        if color.whiteText {
            return Color.white
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(colorManager.getColor(hex: color.hex))
                    .foregroundColor(.red)
                    .cornerRadius(15)
                VStack(alignment: .leading) {
                    HStack {
                        Text("#\(color.hex)")
                            .font(.subheadline)
                        Spacer()
                        Text(color.note)
                            .font(.subheadline)
                    }
                    Text(color.name)
                        .font(.title)
                    HStack {
                        Text("September 10")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding()
                .foregroundStyle(textColor)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    ColorCard(color: UserColor(name: "Blue", hex: "007AFF", category: "Blue", date: Date(), note: "Bedroom wall", whiteText: true))
}
