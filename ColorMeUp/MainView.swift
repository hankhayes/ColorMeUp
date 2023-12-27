//
//  MainView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TestView()
                .tabItem {
                    VStack {
                        Image(systemName: "pencil")
                        Text("Test")
                    }
                }
            ColorsView()
                .tabItem {
                    VStack {
                        Image(systemName: "paintpalette")
                        Text("Colors")
                    }
                }
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera")
                        Text("Capture")
                    }
                }
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
        }
    }
}

#Preview {
    MainView()
}
