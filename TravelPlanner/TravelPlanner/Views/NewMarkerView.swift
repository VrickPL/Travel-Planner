//
//  NewMarkerView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 09/08/2024.
//

import MapKit
import SwiftUI

struct NewMarkerView: View {
    @State var newMarker: MKMapItem
    @Binding var isPresented: Bool

    @State private var name = ""
    @State private var description = ""

    var body: some View {
        VStack {
            Group {
                TextField("name", text: $name, axis: .vertical)
                    .font(.title)
                    .padding(.top)

                Divider()
                    .background(.black)

                TextField("description", text: $description, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical)
            }

            Spacer()

            Button {
                newMarker.openInMaps(launchOptions: nil)
            } label: {
                HStack {
                    Image(systemName: "apple.logo")

                    Text("open_maps")
                }.font(.headline)
                    .padding()
                    .cornerRadius(10)
            }

            HStack {
                Button {
                    isPresented = false
                } label: {
                    Text("cancel")
                        .font(.headline)
                        .tint(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.gray)
                        .cornerRadius(15)
                }
                .layoutPriority(1)

                Button {
                    // TODO: add marker
                    isPresented = false
                } label: {
                    Text("add_marker")
                        .font(.headline)
                        .tint(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .cornerRadius(15)
                }
                .layoutPriority(1)
            }.padding(.vertical)
        }.onAppear {
            if name.isEmpty {
                setDefaultLocationName()
            }
        }
    }

    private func setDefaultLocationName() {
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

            if let locationName = placemark.name {
                name = locationName
            }
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
