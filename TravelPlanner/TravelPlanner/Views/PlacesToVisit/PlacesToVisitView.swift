//
//  PlacesToVisitView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct PlacesToVisitView: View {
    @State private var viewModel = PlacesToVisitViewModel()

    @Query private var placesToVisit: [MarkerItem]
    //    @State var placesToVisit: [MarkerItem] = []
    @State private var selectedPlace: MarkerItem?

    @State private var selectedFilter: FilterOption = .all

    var body: some View {
        NavigationView {
            VStack {
                if placesToVisit.isEmpty {
                    Text("empty_list")
                        .padding()
                } else {
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(FilterOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onAppear {
                        viewModel.updateMarkersByName(
                            placesToVisit: placesToVisit,
                            selectedFilter: selectedFilter
                        )
                    }

                    if selectedFilter == .all {
                        ListOfPlacesView(placesToVisit: placesToVisit)
                            .refreshable {
                                viewModel.updateMarkersByName(
                                    placesToVisit: placesToVisit,
                                    selectedFilter: selectedFilter
                                )
                            }
                    } else {
                        ScrollView {
                            FilteredListOfPlacesView(
                                names: $viewModel.names,
                                markersByName: $viewModel.markersByName
                            )
                        }
                        .refreshable {
                            viewModel.updateMarkersByName(
                                placesToVisit: placesToVisit,
                                selectedFilter: selectedFilter
                            )
                        }
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
            .onChange(of: selectedFilter) {
                viewModel.updateMarkersByName(
                    placesToVisit: placesToVisit,
                    selectedFilter: selectedFilter
                )
            }
        }
    }
}

//#Preview {
//    PlacesToVisitView(
//        placesToVisit: [
//            MarkerItem(
//                placeName: "Apple",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "US",
//                city: "Cupertino"
//            ),
//            MarkerItem(
//                placeName: "Facebook",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "US",
//                city: "Cupertino"
//            ),
//            MarkerItem(
//                placeName: "Twitter",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "US",
//                city: "New York"
//            ),
//            MarkerItem(
//                placeName: "Pudliszki",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "Polska",
//                city: "Pudliszki"
//            ),
//            MarkerItem(
//                placeName: "PGE Narodowy",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "Polska",
//                city: "Warszawa"
//            ),
//            MarkerItem(
//                placeName: "Dworzec Główny",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "Polska",
//                city: "Warszawa"
//            ),
//            MarkerItem(
//                placeName: "Kebab",
//                placeDescription:
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
//                longitude: -122.0090,
//                latitude: 37.3349,
//                country: "Germany",
//                city: "Berlin"
//            ),
//        ]
//    )
//}
