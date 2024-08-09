//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import SwiftUI
import SwiftData

@main
struct TravelPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MarkerItem.self)
    }
}
