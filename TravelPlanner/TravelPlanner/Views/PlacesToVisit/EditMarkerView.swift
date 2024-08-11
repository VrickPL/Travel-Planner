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

    var body: some View {
        VStack {
            Map(position: $cameraPosition) {
                Marker(item: markerItem.getAsMKMapItem())
                    .annotationTitles(.hidden)
            }
            .cornerRadius(10)

            Spacer()

            PlaceDescriptionView(
                name: $name,
                description: $description
            )

            Spacer()
            
            MarkerViewButtons(
                isPresented: $isPresented,
                isAcceptButtonAvailable: !name.isEmpty,
                acceptButtonName: "save_changes",
                mapItem: markerItem.getAsMKMapItem(),
                onAccept: updateMarker
            )
        }.onAppear {
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
            latitude: 37.3349
        ),
        isPresented: .constant(true)
    )
}
