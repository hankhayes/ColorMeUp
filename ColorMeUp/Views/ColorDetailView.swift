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
        VStack {
            Text(color.hex)
            Text(color.name)
            Text(color.note)
        }
    }
}

#Preview {
    ColorDetailView(color: UserColor(name: "Test", hex: "fafafa", category: "Blue", date: Date(), note: "none", whiteText: true))
}
