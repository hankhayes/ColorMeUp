//
//  ManualCaptureView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/1/24.
//

import SwiftUI

struct ManualCaptureView: View {
    // Environment
    @Environment(\.modelContext) private var modelContext
    
    // ColorManager is a custom class that makes a variety of calculations relating to the UserColor class
    let colorManager = ColorManager()
    
    // Variables
    @State var selectedColor: Color = .red
    @State var colorNote: String = ""
    
    // These are primarily binded to CaptureView
    @Binding var showAlert: Bool
    @Binding var manualCaptureIsShowing: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Manual Capture")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                VStack(spacing: 20) {
                    ColorPicker("Select a color", selection: $selectedColor, supportsOpacity: false)
                    HStack {
                        Text("Notes")
                        Spacer()
                        TextField("What is this color for?", text: $colorNote)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    // This button takes the color currently selected in the ColorPicker and creates a new UserColor based on the user's input
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
                        manualCaptureIsShowing = false
                        showAlert = true
                    }, label: {
                        Text("Save")
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    ManualCaptureView(showAlert: Binding.constant(false), manualCaptureIsShowing: Binding.constant(true))
}
