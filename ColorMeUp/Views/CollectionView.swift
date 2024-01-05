//
//  CollectionView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    
    let colorManager = ColorManager()
    
    @EnvironmentObject var appColor: AppColor
    @Environment(\.modelContext) private var modelContext
    @Query private var colors: [UserColor]
    @State var filters = ["red": false, "orange": false, "yellow": false, "green": false, "blue": false, "purple": false]
    
    var body: some View {
        NavigationStack {
            VStack {
//                HStack {
//                    Text("Colors")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                    Spacer()
//                }
//                .padding(.horizontal)
                CategoryScroller(filters: $filters)
                    .padding(.horizontal)
                    .tint(appColor.tint)
                ScrollView(showsIndicators: false) {
                    VStack {
                        let valuesSequence = filters.values
                        ForEach(colors) { color in
                            if filters[color.category]! || valuesSequence.allSatisfy({$0 == false}) {
                                NavigationLink {
                                    ColorDetailView(color: color)
                                } label: {
                                    ColorCard(color: color)
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Colors")
        }
    }
}

#Preview {
    CollectionView()
}
