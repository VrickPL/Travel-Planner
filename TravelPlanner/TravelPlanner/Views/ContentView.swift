//
//  ContentView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("map")
                }
            
            PlacesToVisitListView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("places_to_visit")
                }
        }
    }
}

#Preview {
    ContentView()
}
