//
//  AppleMapsButton.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 12/08/2024.
//

import MapKit
import SwiftUI

struct AppleMapsButton: View {
    @State var item: MKMapItem

    var body: some View {
        Button {
            item.openInMaps(launchOptions: nil)
        } label: {
            HStack {
                Image(systemName: "apple.logo")

                Text("open_maps")
            }.font(.headline)
                .padding()
                .cornerRadius(10)
        }
    }
}

#Preview {
    AppleMapsButton(
        item: MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.3349, longitude: -122.0090
                )
            )
        )
    )
}
