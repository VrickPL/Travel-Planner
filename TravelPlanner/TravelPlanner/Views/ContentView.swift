//
//  ContentView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(Keys.SELECTED_LANGUAGE) private var selectedLanguage:
        Language = Language.systemDefault
    @AppStorage(Keys.SELECTED_THEME) private var selectedTheme:
        Theme = Theme.systemDefault
    
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("map")
                }
            
            PlacesToVisitView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("places_to_visit")
                }
        }
        .environment(\.locale, selectedLanguage.locale)
        .environment(\.colorScheme, selectedColorScheme)
    }
    
    private var selectedColorScheme: ColorScheme {
        return selectedTheme.colorScheme ?? systemColorScheme
    }
}

#Preview {
    ContentView()
}
