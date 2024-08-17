//
//  MapView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import MapKit
import SwiftData
import SwiftUI
import TipKit

struct MapView: View {
    @Query private var placesToVisit: [MarkerItem]

    @State private var cameraPosition: MapCameraPosition = .userLocation(
        fallback: .automatic)
    @State private var selection: MarkerItem?

    @State private var searchCityText = ""
    @State private var isSearchEnabled = false

    @State private var isAddMarkerEnabled = false
    @State private var isAddMarkerSheetPresented = false
    @State private var newMarker: MKMapItem?

    @State private var isEditMarkerSheetPresented = false
    @State private var editMarker: MarkerItem?

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
                        .tint(.blue)
                        .annotationTitles(.hidden)
                }

                ForEach(placesToVisit, id: \.self) { place in
                    Marker(item: place.getAsMKMapItem())
                        .annotationTitles(.hidden)
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()

                    VStack {
                        CustomMapButton(
                            isEnabled: $isAddMarkerEnabled,
                            systemImageName: "plus"
                        )
                        .popoverTip(AddMarkerTip(), arrowEdge: .bottom)

                        CustomMapButton(
                            isEnabled: $isSearchEnabled,
                            systemImageName: "magnifyingglass"
                        )
                    }
                }
                .padding(.trailing, 4)
                .padding(.bottom, 20)
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
                    .padding(.top)
                }
            }
            .sheet(item: $selection) { marker in
                if isEditMarkerSheetPresented {
                    EditMarkerView(
                        markerItem: marker,
                        isPresented: $isEditMarkerSheetPresented,
                        isMapVisible: false
                    )
                    .padding()
                    .padding(.top)
                    .presentationDetents([.fraction(0.5)])
                } else {
                    MarkerSelectedView(
                        marker: marker,
                        selection: $selection,
                        editMarker: $editMarker,
                        isEditMarkerSheetPresented: $isEditMarkerSheetPresented
                    )
                    .padding()
                    .presentationDetents([.fraction(0.5)])
                    .onAppear {
                        cameraPosition = .item(marker.getAsMKMapItem())
                    }
                }
            }
            .onChange(of: isEditMarkerSheetPresented) {
                if !isEditMarkerSheetPresented {
                    selection = nil
                    editMarker = nil
                }
            }
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

    private struct MarkerSelectedView: View {
        @Environment(\.modelContext) private var context

        @State var marker: MarkerItem
        @Binding var selection: MarkerItem?
        @Binding var editMarker: MarkerItem?
        @Binding var isEditMarkerSheetPresented: Bool

        var body: some View {
            VStack {
                Button {
                    editMarker = marker
                    isEditMarkerSheetPresented = true
                } label: {
                    PlaceImageView(imageData: $marker.imageData)
                        .frame(width: 250)
                        .scaleEffect(3)
                }
                .padding()
                .padding()
                .padding(.top)

                HStack {
                    Text(marker.placeName)
                        .font(.title)
                        .padding(.top)

                    Spacer()
                }

                Divider()
                    .background(Color("ForegroundColor"))
                
                Spacer()

                MarkerViewButtons(
                    isPresented: .constant(true),
                    acceptButtonName: "edit",
                    acceptButtonColor: .blue,
                    declineButtonName: "delete",
                    declineButtonColor: .red,
                    mapItem: marker.getAsMKMapItem(),
                    isAcceptButtonAvailable: { true },
                    onAccept: {
                        editMarker = marker
                        isEditMarkerSheetPresented = true
                    },
                    onDecline: {
                        deleteMarker(marker)
                        selection = nil
                    }
                )
            }
        }

        private func deleteMarker(_ markerItem: MarkerItem) {
            context.delete(markerItem)
        }
    }
}

#Preview {
    MapView()
}
