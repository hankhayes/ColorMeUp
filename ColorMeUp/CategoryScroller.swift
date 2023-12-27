//
//  CategoryScroller.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct CategoryScroller: View {
    
    @State var redSelected = false
    @State var orangeSelected = false
    @State var yellowSelected = false
    @State var greenSelected = false
    
    @Binding var filters: [String: Bool]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                Toggle("Red", isOn: $redSelected)
                    .toggleStyle(.button)
                    .onChange(of: redSelected, {
                        filters["red"]!.toggle()
                    })
                Toggle("Orange", isOn: $orangeSelected)
                    .toggleStyle(.button)
                    .onChange(of: orangeSelected, {
                        filters["orange"]!.toggle()
                    })
                Toggle("Yellow", isOn: $yellowSelected)
                    .toggleStyle(.button)
                    .onChange(of: yellowSelected, {
                        filters["yellow"]!.toggle()
                    })
                Toggle("Green", isOn: $greenSelected)
                    .toggleStyle(.button)
                    .onChange(of: greenSelected, {
                        filters["green"]!.toggle()
                    })
            }
        }
    }
}

#Preview {
    CategoryScroller(filters: Binding.constant(["red": false, "orange": false, "yellow": false, "green": false]))
}
