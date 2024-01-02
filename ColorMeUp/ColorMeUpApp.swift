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
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
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

    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(sharedModelContainer)
    }
}
