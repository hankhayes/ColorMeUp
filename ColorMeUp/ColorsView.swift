//
//  ColorsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ColorsView: View {
    
    @State var colors = [UserColor]()
    var dataService = DataService()
    
    @State var filters = ["red": false, "orange": false, "yellow": false, "green": false]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Colors")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    Spacer()
                }
                CategoryScroller(filters: $filters)
                    .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    VStack() {
                        let valuesSequence = filters.values
                        ForEach(colors) { color in
                            if filters[color.category]! || valuesSequence.allSatisfy({$0 == false}) {
                                NavigationLink {
                                    ColorDetailView(color: color)
                                } label: {
                                    ColorCard(colorName: "Azure Radiance", color: color)
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                colors = dataService.getColors()
            }
        }
    }
}

#Preview {
    ColorsView(filters: [:])
}
