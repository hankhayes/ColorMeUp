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
        ZStack {
            Rectangle()
                .foregroundColor(color.getColor())
                .cornerRadius(15)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("#\(color.hex)")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(color.note)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
                HStack {
                    Text("September 10")
                        .font(.headline)
                    Spacer()
                }
                .padding()
            }
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ColorCard(color: UserColor(hex: "007AFF", date: Date(), note: "Bedroom wall", category: "Red"))
}
