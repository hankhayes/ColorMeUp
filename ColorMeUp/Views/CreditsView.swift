//
//  CreditsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/6/24.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Credits")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top)
                .padding(.bottom, 1)
                HStack {
                    Text("Created and designed by The Puma Pod")
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                HStack {
                    Text("Tristan Lofgren")
                    Spacer()
                }
                HStack {
                    Text("Tyla Tennant")
                    Spacer()
                }
                HStack {
                    Text("Megan Stelter")
                    Spacer()
                }
                HStack {
                    Text("Lesly Hernandez")
                    Spacer()
                }
                HStack {
                    Text("Grant Haidu")
                    Spacer()
                }
                HStack {
                    Text("Hank Hayes")
                    Spacer()
                }
            }
            .padding(.horizontal)
            VStack {
                HStack {
                    Text("Developed by")
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                HStack {
                    Text("Hank Hayes")
                    Spacer()
                }
            }
            .padding(.vertical, 1)
            .padding(.horizontal)
            VStack {
                HStack {
                    Text("Special thanks")
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                HStack {
                    Text("This app couldn't have been developed without the shared ideas of The Puma Pod and the Campus Leader Program.")
                    Spacer()
                }
            }
            .padding(.vertical, 1)
            .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    CreditsView()
}
