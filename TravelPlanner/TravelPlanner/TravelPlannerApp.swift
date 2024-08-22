//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct TravelPlannerApp: App {
    @AppStorage(Keys.SELECTED_LANGUAGE) private var selectedLanguage: Language = Language.systemDefault
    @AppStorage(Keys.SELECTED_THEME) private var selectedTheme: Theme = Theme.systemDefault

    @Environment(\.colorScheme) var systemColorScheme

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                .environment(\.locale, selectedLanguage.locale)
                .environment(\.colorScheme, selectedColorScheme)
        }
        .modelContainer(for: MarkerItem.self)
    }

    private var selectedColorScheme: ColorScheme {
        return selectedTheme.colorScheme ?? systemColorScheme
    }
}
