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
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
            ColorPicker("Use the eyedropper", selection: Binding.constant(.red))
            HStack {
                Text("Name")
                Spacer()
                TextField("enter text", text: $colorName)
            }
            Button(action: {
                print("hi")
            }, label: {
                Text("Save color")
            })
        }
    }
}

#Preview {
    GetColorFromImageView()
}
