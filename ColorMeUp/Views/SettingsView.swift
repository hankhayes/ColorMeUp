//
//  SettingsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct SettingsView: View {
    
    // User Defaults
    @AppStorage ("isDarkMode") private var isDarkMode = false
    @AppStorage ("visionType") private var visionType = 0
    
    // Environment
    @EnvironmentObject var appColor: AppColor
    
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
                            Picker("", selection: $visionType) {
                                Text("No color-blindness").tag(0)
                                Text("Red-Green Colorblind").tag(1)
                                Text("Blue-Yellow Colorblind").tag(2)
                            }
                            .onChange(of: visionType) {
                                switch visionType {
                                case 0:
                                    appColor.tint = .blue
                                case 1:
                                    appColor.tint = .blue
                                case 2:
                                    appColor.tint = .red
                                default:
                                    print()
                                }
                            }
                            .foregroundColor(.secondary)
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
