//
//  ColorMeUpApp.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI
import SwiftData

@main
struct ColorMeUpApp: App {
    
    // User defaults
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage ("visionType") private var visionType = 0
    
    @ObservedObject var appColor = AppColor()
    
    // Swift Data
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserColor.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(AppColor())
        }
        .modelContainer(sharedModelContainer)
    }
}
