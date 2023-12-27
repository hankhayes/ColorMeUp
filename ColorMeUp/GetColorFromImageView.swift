//
//  GetColorFromImageView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct GetColorFromImageView: View {
    
    @State var colorName: String = ""
    
    var image: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: image)
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
    GetColorFromImageView(image: UIImage(systemName: "person")!)
}
