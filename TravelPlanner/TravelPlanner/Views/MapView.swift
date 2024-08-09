//
//  MapView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var selection: MapSelection<MKMapItem>?

    @State private var searchCityText = ""
    @State private var isSearchEnabled = false

    @State private var placesToVisit: [MKMapItem] = []

    @State private var isAddMarkerEnabled = false
    @State private var isAddMarkerMode = false
    @State private var newMarker: MKMapItem?

    var body: some View {
        if isSearchEnabled {
            NavigationStack {
                mapView
            }
            .searchable(text: $searchCityText)
            .onChange(of: searchCityText) {
                setCameraBasedOnSearch()
            }
        } else {
            mapView
        }
    }

    private var mapView: some View {
        MapReader { proxy in
            Map(position: $cameraPosition, selection: $selection) {
                UserAnnotation()

                ForEach(placesToVisit, id: \.self) { place in
                    Marker(item: place)
                }
                .mapItemDetailSelectionAccessory(
                    isAddMarkerEnabled ? .none : .sheet)
            }
            .mapFeatureSelectionAccessory(isAddMarkerEnabled ? .none : .sheet)
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .onTapGesture { position in
                if isAddMarkerEnabled {
                    if let coordinate = proxy.convert(position, from: .local) {
                        newMarker = MKMapItem(
                            placemark: MKPlacemark(
                                coordinate: coordinate
                            )
                        )

                        isAddMarkerMode.toggle()
                    }
                }
            }
            .onAppear {
                CLLocationManager().requestWhenInUseAuthorization()
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()

                    VStack {
                        CustomMapButton(
                            isEnabled: $isAddMarkerEnabled,
                            systemImageName: "plus"
                        )

                        CustomMapButton(
                            isEnabled: $isSearchEnabled,
                            systemImageName: "magnifyingglass"
                        )
                    }
                }
                .padding(.trailing, 4)
                .padding(.bottom, 20)
            }
            .sheet(isPresented: $isAddMarkerMode, onDismiss: {
                isAddMarkerEnabled = false
            }) {
                NewMarkerView(newMarker: newMarker)
                    .presentationDetents([.fraction(0.5)])
                //                placesToVisit.append(newItem)
            }
        }
    }

    private struct CustomMapButton: View {
        @Binding var isEnabled: Bool
        var systemImageName: String

        var body: some View {
            Button {
                isEnabled.toggle()
            } label: {
                Image(systemName: systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            }
            .padding(12)
            .tint(isEnabled ? .white : .blue)
            .background(isEnabled ? .blue : .clear)
            .background(.thinMaterial)
            .cornerRadius(15)
        }
    }

    private func setCameraBasedOnSearch() {
        if !searchCityText.isEmpty {
            Task {
                guard let city = await findCity() else {
                    return
                }
                cameraPosition = .item(city)
            }
        }
    }

    private func findCity() async -> MKMapItem? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchCityText

        request.addressFilter = MKAddressFilter(
            including: .locality
        )

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        return response?.mapItems.first
    }
}

#Preview {
    MapView()
}
