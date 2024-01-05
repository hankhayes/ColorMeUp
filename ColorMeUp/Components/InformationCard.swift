//
//  InformationCard.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI

struct InformationCard: View {
    
    @EnvironmentObject var appColor: AppColor
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.myGray)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                HStack {
                    Text("Quick Start")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Read more")
                        .font(.subheadline)
                    Image(systemName: "info.circle")
                        .imageScale(.small)
                }
                .foregroundStyle(appColor.tint)
                .padding(.bottom, 1)
                Text("Click one of the options below to capture a new color. You can select a color from a photo, take a new photo, or add a color manually!")
                    .multilineTextAlignment(.leading)
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
