//
//  MainView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct MainView: View {
    // Environment
    @EnvironmentObject var appColor: AppColor
    
    // Variables
    @State private var selection: Int = 3
    
    var body: some View {
        TabView(selection: $selection) {
            TestView()
                .tabItem {
                    VStack {
                        Image(systemName: "pencil")
                        Text("Test")
                    }
                }
                .tag(1)
            CollectionView()
                .tabItem {
                    VStack {
                        Image(systemName: "paintpalette")
                        Text("Colors")
                    }
                }
                .tag(2)
            CaptureView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(3)
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
                .tag(4)
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(5)
        }
        .background(.myGray)
        .tint(appColor.tint)
    }
}

#Preview {
    MainView()
}
