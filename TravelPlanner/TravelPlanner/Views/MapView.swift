//
//  MapView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import MapKit
import SwiftUI
import SwiftData

struct MapView: View {
    @Query private var placesToVisit: [MarkerItem]
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selection: MapSelection<MKMapItem>?

    @State private var searchCityText = ""
    @State private var isSearchEnabled = false

    @State private var isAddMarkerEnabled = false
    @State private var isAddMarkerSheetPresented = false
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
                
                if let newMarker = newMarker {
                    Marker(item: newMarker)
                        .annotationTitles(.hidden)
                }

                ForEach(placesToVisit, id: \.self) { place in
                    Marker(item: place.asMKMapItem())
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

                        guard let newMarker else {
                            return
                        }

                        cameraPosition = .item(newMarker)
                        isAddMarkerSheetPresented = true
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
            .sheet(
                isPresented: $isAddMarkerSheetPresented,
                onDismiss: {
                    newMarker = nil
                    isAddMarkerEnabled = false
                }
            ) {
                if let newMarker = newMarker {
                    NewMarkerView(
                        newMarker: newMarker,
                        isPresented: $isAddMarkerSheetPresented
                    )
                    .presentationDetents([.fraction(0.5)])
                    .padding()
                }
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
