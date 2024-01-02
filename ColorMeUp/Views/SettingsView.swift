//
//  SettingsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage ("isDarkMode") private var isDarkMode = false
    @AppStorage ("visionType") private var visionType = "No color-blindness"
    @State var text: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Appearance") {
                        HStack {
                            Text("Dark mode")
                            Spacer()
                            Toggle("", isOn: $isDarkMode)
                        }
                        HStack {
                            Text("Vision type")
                            Spacer()
                            Picker("", selection: $visionType, content: {
                                Text("No color-blindness").tag(0)
                                Text("Deuteranomaly").tag(1)
                                Text("Protanomaly").tag(2)
                                Text("Protanopia").tag(3)
                                Text("Deuteranopia").tag(4)
                                Text("Tritanomaly").tag(5)
                                Text("Tritanopia").tag(6)
                            })
                        }
                    }
                    Section("Account") {
                        HStack {
                            Text("Email")
                            Spacer()
                            Button(action: {
                                print()
                            }, label: {
                                Text("Change")
                            })
                        }
                        HStack {
                            Text("Password")
                            Spacer()
                            Button(action: {
                                print()
                            }, label: {
                                Text("Change")
                            })
                        }
                    }
                }

            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
