//
//  GetColorFromImageView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct GetColorFromImageView: View {
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    
    // Variables
    @State var colorNote: String = ""
    @State var selectedColor: Color = .red
    
    // Tied to variables in CaptureView
    @Binding var takenImage: UIImage
    @Binding var showAlert: Bool
    @Binding var didSelectImageFromLibrary: Bool
    
    // ColorManager is a custom class that makes a variety of calculations relating to the UserColor class
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
                // This button creates a new user color based on the ColorPicker selection
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
                    showAlert = true
                    didSelectImageFromLibrary = false
                }, label: {
                    Text("Save")
                        .padding()
                })
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    GetColorFromImageView(takenImage: Binding.constant(UIImage()), showAlert: Binding.constant(true), didSelectImageFromLibrary: Binding.constant(false))
}
