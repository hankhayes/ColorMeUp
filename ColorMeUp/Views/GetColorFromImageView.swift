//
//  GetColorFromImageView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI
// import Photos

struct GetColorFromImageView: View {
    
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    
    @State var colorNote: String = ""
    @State var selectedColor: Color = .red
    @Binding var takenImage: UIImage
    
    let colorManager = ColorManager()
    
    var body: some View {
        VStack {
            HStack {
                Text("Photo Capture")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image(uiImage: takenImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(spacing: 20) {
                ColorPicker("Use the eyedropper", selection: $selectedColor, supportsOpacity: false)
                HStack {
                    Text("Notes")
                    Spacer()
                    TextField("Enter text", text: $colorNote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button(action: {
                    let hex = colorManager.getHex(color: selectedColor)
                    let category = colorManager.getCategory(hex: hex)
                    let name = colorManager.getName(hex: hex)
                    let whiteText = colorManager.getTextColor(hex: hex)
                    
                    let newColor = UserColor(
                        name: name,
                        hex: hex,
                        category: category,
                        date: Date(),
                        note: colorNote,
                        whiteText: whiteText
                    )
                    modelContext.insert(newColor)
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
    GetColorFromImageView(takenImage: Binding.constant(UIImage()))
}
