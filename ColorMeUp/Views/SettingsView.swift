//
//  SettingsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage ("isDarkMode") private var isDarkMode = false
    @AppStorage ("visionType") private var visionType = 0
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
                                .tint(appColor.tint)
                        }
                        HStack {
                            Text("Vision type")
                            Spacer()
                            Picker("", selection: $visionType) {
                                Text("No color-blindness").tag(0)
                                Text("Deuteranomaly").tag(1)
                                Text("Protanomaly").tag(2)
                                Text("Protanopia").tag(3)
                                Text("Deuteranopia").tag(4)
                                Text("Tritanomaly").tag(5)
                                Text("Tritanopia").tag(6)
                            }
                            .onChange(of: visionType) {
                                switch visionType {
                                case 0:
                                    appColor.tint = .red
                                case 1:
                                    appColor.tint = .orange
                                case 2:
                                    appColor.tint = .yellow
                                case 3:
                                    appColor.tint = .green
                                case 4:
                                    appColor.tint = .blue
                                case 5:
                                    appColor.tint = .purple
                                case 6:
                                    appColor.tint = .indigo
                                default:
                                    print()
                                }
                            }
                            .tint(appColor.tint)
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
                                    .tint(appColor.tint)
                            })
                        }
                        HStack {
                            Text("Password")
                            Spacer()
                            Button(action: {
                                print()
                            }, label: {
                                Text("Change")
                                    .tint(appColor.tint)
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
