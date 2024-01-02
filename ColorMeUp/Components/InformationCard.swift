//
//  InformationCard.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI

struct InformationCard: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.myGray)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "info")
                        .foregroundColor(.blue)
                    Text("Quick Start")
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    Spacer()
                }
                .padding(.bottom, 6)
                Text("Click one of the options below to capture a new color. You can select a color from a photo, take a new photo, or add a color manually!")
                    .multilineTextAlignment(.leading) // Set text alignment
                Spacer()
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    InformationCard()
}
