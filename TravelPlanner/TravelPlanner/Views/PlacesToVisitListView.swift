//
//  PlacesToVisitListView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct PlacesToVisitListView: View {
    @Environment(\.modelContext) private var context

    @Query private var placesToVisit: [MarkerItem]
    @State private var selectedPlace: MarkerItem?

    @State private var isNewMarketSheetEnabled = false

    var body: some View {
        // TODO: if list is empty, show text describing it
        // TODO: dark theme colors
        NavigationView {
            List {
                ForEach(placesToVisit) { place in
                    Button {
                        selectedPlace = place
                        isNewMarketSheetEnabled = true
                    } label: {
                        HStack {
                            Text(place.placeName)
                            Spacer()
                            Image(systemName: "pencil")
                        }
                        .tint(.black)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteMarker(placesToVisit[index])
                    }
                }
            }
            .navigationBarItems(
                trailing: NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
            )
            .onChange(of: selectedPlace) {
                if let selectedPlace = selectedPlace {
                    print("zmiana - \(selectedPlace.placeName)")
                } else {
                    print("zmiana - nil")
                }
            }
            .sheet(
                isPresented: $isNewMarketSheetEnabled,
                onDismiss: {
                    isNewMarketSheetEnabled = false
                }
            ) {
                if let selectedPlace = selectedPlace {
                    EditMarkerView(
                        markerItem: selectedPlace,
                        isPresented: $isNewMarketSheetEnabled
                    )
                    .padding()
                }
            }
        }
    }

    func deleteMarker(_ markerItem: MarkerItem) {
        context.delete(markerItem)
    }
}

#Preview {
    PlacesToVisitListView()
}
