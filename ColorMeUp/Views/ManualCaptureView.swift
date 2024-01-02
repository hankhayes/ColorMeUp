//
//  ManualCaptureView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/1/24.
//

import SwiftUI

struct ManualCaptureView: View {
    
    @Environment(\.modelContext) private var modelContext
    let colorManager = ColorManager()
    
    @State var selectedColor: Color = .red
    @State var colorNote: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ColorPicker("Select a color", selection: $selectedColor, supportsOpacity: false)
                HStack {
                    Text("Notes")
                    Spacer()
                    TextField("What is this color for?", text: $colorNote)
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
                        Text("Save")
                            .padding()
                    })
                
            }
            .padding()
        }
        .navigationTitle("Capture")
    }
}


#Preview {
    ManualCaptureView()
}
