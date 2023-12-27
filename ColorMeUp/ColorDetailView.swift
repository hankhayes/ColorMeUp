//
//  ColorDetailView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ColorDetailView: View {
    
    var color: UserColor
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ColorDetailView(color: UserColor(hex: "fafafa", date: Date(), note: "none", category: "Red"))
}
