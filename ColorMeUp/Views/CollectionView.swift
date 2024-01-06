//
//  CollectionView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    
    // ColorManager is a custom class that makes a variety of calculations relating to the UserColor class
    var colorManager = ColorManager()
    
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query private var colors: [UserColor]
    
    // Variables
    @State var filters = ["red": false, "orange": false, "yellow": false, "green": false, "blue": false, "purple": false]
    @State var selectedColor: UserColor?
    @State var colorCardWasSelected: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                CategoryScroller(filters: $filters)
                    .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    VStack {
                        let valuesSequence = filters.values
                        ForEach(colors) { color in
                            if filters[color.category]! || valuesSequence.allSatisfy({$0 == false}) {
                                ColorCard(color: color)
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Colors")
            .onChange(of: selectedColor) {
                colorCardWasSelected = true
            }
            .sheet(isPresented: $colorCardWasSelected, onDismiss: {
                colorCardWasSelected = false
            }, content: {
                ColorDetailView(color: selectedColor!)
                    .presentationDetents([.medium, .large])
            })
        }
    }
}

#Preview {
    CollectionView()
}
