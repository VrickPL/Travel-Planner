//
//  PlacesToVisitListView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import SwiftUI
import MapKit

struct PlacesToVisitListView: View {
    @State private var selectedPlace: MKMapItem?
    private var places: [MKMapItem] = []
    
    var body: some View {
        List(
            places,
            id: \.self,
            selection: $selectedPlace
        ) {
            Text($0.name ?? "Place to visit")
        }
        .mapItemDetailSheet(item: $selectedPlace)
    }
}

#Preview {
    PlacesToVisitListView()
}
