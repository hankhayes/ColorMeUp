//
//  SwiftUIView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/27/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var text: String
    
    var body: some View {
        VStack {
            Text("Hi")
            Spacer()
            Spacer()
            Spacer()
            TextField("hello", text: $text)
            Spacer()
            Text("Ho")
                .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    SwiftUIView(text: "Hello")
}
