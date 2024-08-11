//
//  EditMarkerView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 09/08/2024.
//

import MapKit
import SwiftUI

struct EditMarkerView: View {
    @Environment(\.modelContext) private var context

    @State var markerItem: MarkerItem
    @Binding var isPresented: Bool

    @State private var name = ""
    @State private var description = ""

    @State private var cameraPosition: MapCameraPosition = .automatic
    @FocusState private var isInputActive: Bool

    var body: some View {
        VStack {
            if !isInputActive {
                Map(position: $cameraPosition) {
                    Marker(item: markerItem.getAsMKMapItem())
                        .annotationTitles(.hidden)
                }
                .cornerRadius(10)
                .onAppear {
                    setCameraToMarker()
                }

                Spacer()
            }

            PlaceDescriptionView(
                name: $name,
                description: $description,
                isInputActive: $isInputActive
            )

            Spacer()

            MarkerViewButtons(
                isPresented: $isPresented,
                acceptButtonName: "save_changes",
                mapItem: markerItem.getAsMKMapItem(),
                isAcceptButtonAvailable: isNameNotEmpty,
                onAccept: updateMarker
            )
        }
        .animation(.bouncy, value: isInputActive)
    }
    
    private func setCameraToMarker() {
        name = markerItem.placeName
        description = markerItem.placeDescription

        let coordinates = CLLocationCoordinate2D(
            latitude: markerItem.latitude,
            longitude: markerItem.longitude
        )

        cameraPosition = .camera(
            MapCamera.init(
                MKMapCamera(
                    lookingAtCenter: coordinates,
                    fromDistance: 1000,
                    pitch: 0,
                    heading: 0
                )
            )
        )
    }

    private var isNameNotEmpty: () -> Bool {
        return {
            !name.isEmpty
        }
    }

    private var updateMarker: () -> Void {
        return {
            markerItem.placeName = name
            markerItem.placeDescription = description

            try? context.save()
        }
    }
}

#Preview {
    EditMarkerView(
        markerItem: MarkerItem(
            placeName: "Apple",
            placeDescription:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
            longitude: -122.0090,
            latitude: 37.3349,
            country: "US",
            city: "Cupertino"
        ),
        isPresented: .constant(true)
    )
}
