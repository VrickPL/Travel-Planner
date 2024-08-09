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
            //TODO: on tap go to content view or mapview
            //TODO: button to return to this marker
            Map(position: $cameraPosition) {
                Marker(item: markerItem.asMKMapItem())
                    .annotationTitles(.hidden)
            }
            .cornerRadius(10)

            Spacer()
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
                markerItem.asMKMapItem().openInMaps(launchOptions: nil)
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
                    // TODO: add check if name is not empty
                    if !name.isEmpty {
                        updateMarker()
                        isPresented = false
                    }
                } label: {
                    Text("save_changes")
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
                    )))
        }
    }

    func updateMarker() {
        markerItem.placeName = name
        markerItem.placeDescription = description

        try? context.save()
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
