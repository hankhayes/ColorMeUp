//
//  ColorDetailView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ColorDetailView: View {
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
        VStack {
            VStack {
                HStack {
                    Text("#\(color.hex)")
                    Spacer()
                    Text(color.category)
                }
                HStack {
                    Text(color.name)
                        .font(.title)
                    Spacer()
                }
                HStack {
                    Text(color.note)
                        .font(.subheadline)
                    Spacer()
                }
                HStack {
                    Text(color.date.description)
                        .font(.subheadline)
                    Spacer()
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .foregroundColor(textColor)
        .background(colorManager.getColor(hex: color.hex))
        .ignoresSafeArea()
    }
}

#Preview {
    ColorDetailView(color: UserColor(name: "Azure Radiance", hex: "007ffa", category: "Blue", date: Date(), note: "Bedroom wall", whiteText: true))
}
