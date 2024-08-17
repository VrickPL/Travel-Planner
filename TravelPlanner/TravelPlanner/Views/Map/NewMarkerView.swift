//
//  NewMarkerView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 09/08/2024.
//

import MapKit
import SwiftUI

struct NewMarkerView: View {
    @Environment(\.modelContext) private var context

    @State var newMarker: MKMapItem
    @Binding var isPresented: Bool

    @State private var name = ""
    @State private var description = ""
    @State private var imageData: Data? = nil

    @State private var city: String?
    @State private var country: String?

    @FocusState private var isInputActive: Bool

    var body: some View {
        VStack {
            PlaceDescriptionView(
                name: $name,
                description: $description,
                imageData: $imageData,
                isInputActive: $isInputActive
            )

            Spacer()

            MarkerViewButtons(
                isPresented: $isPresented,
                acceptButtonName: "add_marker",
                mapItem: newMarker,
                isAcceptButtonAvailable: isNameNotEmpty,
                onAccept: addMarker,
                onDecline: {}
            )
        }
        .onAppear {
            if name.isEmpty {
                setDefaultLocationInfo()
            }
        }
    }

    private func setDefaultLocationInfo() {
        let coordinates = newMarker.placemark.coordinate
        let location = CLLocation(
            latitude: coordinates.latitude, longitude: coordinates.longitude)

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                return
            }

            guard let placemark = placemarks?.first else {
                return
            }

            name = placemark.name ?? ""
            self.city = placemark.locality
            self.country = placemark.country
        }
    }

    private var isNameNotEmpty: () -> Bool {
        return {
            !name.isEmpty
        }
    }

    private var addMarker: () -> Void {
        return {
            let coordinates = newMarker.placemark.coordinate
            let markerItem = MarkerItem(
                placeName: name,
                placeDescription: description,
                longitude: coordinates.longitude,
                latitude: coordinates.latitude,
                country: country,
                city: city,
                imageData: imageData
            )

            context.insert(markerItem)
        }
    }
}

#Preview {
    NewMarkerView(
        newMarker: MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.3349, longitude: -122.0090))),
        isPresented: .constant(true)
    )
}
