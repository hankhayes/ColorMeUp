//
//  SettingsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
            List {
                Section("Appearance") {
                    Text("App appearance")
                    Text("Vision type")
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
    }
}

#Preview {
    SettingsView()
}
