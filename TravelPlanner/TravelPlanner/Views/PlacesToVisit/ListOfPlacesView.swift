//
//  ListOfPlacesView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 12/08/2024.
//

import SwiftUI

struct ListOfPlacesView: View {
    @Environment(\.modelContext) private var context
    @State var placesToVisit: [MarkerItem]

    @State private var selectedPlace: MarkerItem? = nil
    @State private var isNewMarkerSheetEnabled = false

    @State var shouldBeCustom = false

    var body: some View {
        VStack {
            if shouldBeCustom {
                ForEach(placesToVisit) { place in
                    Divider()
                        .background(Color("ForegroundColor"))
                        .padding(.horizontal)

                    SinglePlaceView(
                        selectedPlace: $selectedPlace,
                        isNewMarkerSheetEnabled:
                            $isNewMarkerSheetEnabled,
                        place: place
                    )
                    .padding()
                }
            } else {
                List {
                    ForEach(placesToVisit) { place in
                        SinglePlaceView(
                            selectedPlace: $selectedPlace,
                            isNewMarkerSheetEnabled:
                                $isNewMarkerSheetEnabled,
                            place: place
                        )
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            deleteMarker(placesToVisit[index])
                        }
                    }
                }
            }
        }
        .onChange(of: selectedPlace) {}
        .sheet(
            isPresented: $isNewMarkerSheetEnabled,
            onDismiss: {
                isNewMarkerSheetEnabled = false
            }
        ) {
            if let selectedPlace = selectedPlace {
                EditMarkerView(
                    markerItem: selectedPlace,
                    isPresented: $isNewMarkerSheetEnabled
                )
                .padding()
                .padding(.top)
            }
        }
    }

    private func deleteMarker(_ markerItem: MarkerItem) {
        context.delete(markerItem)
    }
}

#Preview {
    ListOfPlacesView(
        placesToVisit: [
            MarkerItem(
                placeName: "Apple",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "US",
                city: "Cupertino",
                imageData: nil
            ),
            MarkerItem(
                placeName: "Facebook",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "US",
                city: "Cupertino",
                imageData: nil
            ),
            MarkerItem(
                placeName: "Twitter",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "US",
                city: "New York",
                imageData: nil
            ),
            MarkerItem(
                placeName: "Pudliszki",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "Polska",
                city: "Pudliszki",
                imageData: nil
            ),
            MarkerItem(
                placeName: "PGE Narodowy",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "Polska",
                city: "Warszawa",
                imageData: nil
            ),
            MarkerItem(
                placeName: "Dworzec Główny",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "Polska",
                city: "Warszawa",
                imageData: nil
            ),
            MarkerItem(
                placeName: "Kebab",
                placeDescription:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
                longitude: -122.0090,
                latitude: 37.3349,
                country: "Germany",
                city: "Berlin",
                imageData: nil
            ),
        ],
        shouldBeCustom: false
    )
}
