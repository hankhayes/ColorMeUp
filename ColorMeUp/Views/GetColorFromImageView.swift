//
//  GetColorFromImageView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI
import Photos

struct GetColorFromImageView: View {
    
    @State var colorName: String = ""
    @State var selectedColor: Color = .red
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(spacing: 20) {
                ColorPicker("Use the eyedropper", selection: $selectedColor, supportsOpacity: false)
                HStack {
                    Text("Notes")
                    Spacer()
                    TextField("Enter text", text: $colorName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button(action: {
                    print("save")
                }, label: {
                    Text("Button")
                        .padding()
                })
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    GetColorFromImageView()
}
