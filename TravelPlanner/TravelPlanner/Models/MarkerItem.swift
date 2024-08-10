//
//  MarkerItem.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 09/08/2024.
//

import Foundation
import MapKit
import SwiftData

@Model
class MarkerItem: Identifiable {
    var id: String
    var placeName: String
    var placeDescription: String
    var longitude: Double
    var latitude: Double

    init(
        placeName: String,
        placeDescription: String,
        longitude: Double,
        latitude: Double
    ) {
        self.id = UUID().uuidString
        self.placeName = placeName
        self.placeDescription = placeDescription
        self.longitude = longitude
        self.latitude = latitude
    }

    func asMKMapItem() -> MKMapItem {
        let placemark = MKPlacemark(
            coordinate: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
        )

        let mapItem = MKMapItem(placemark: placemark)

        mapItem.name = placeName
        return mapItem
    }
}
