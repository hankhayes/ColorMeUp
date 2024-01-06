//
//  InformationCard.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI

struct InformationCard: View {
    
    var title: String
    var info: String
    var readMore: Bool
    
    var readMoreColor: Color {
        if readMore {
            return Color.accentColor
        } else {
            return Color.clear
        }
    }
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.myGray)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.accentColor)
                    Spacer()
                    Text("Read more")
                        .font(.subheadline)
                        .foregroundStyle(readMoreColor)
                    Image(systemName: "info.circle")
                        .imageScale(.small)
                        .foregroundStyle(readMoreColor)
                }
                .padding(.bottom, 1)
                Text(info)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    InformationCard(title: "Quick Start", info: "Click one of the options below to capture a new color. You can select a color from a photo, take a new photo, or add a color manually!", readMore: true)
}
