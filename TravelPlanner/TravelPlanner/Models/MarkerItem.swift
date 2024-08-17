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
    var country: String?
    var city: String?
    var imageData: Data?

    init(
        placeName: String,
        placeDescription: String,
        longitude: Double,
        latitude: Double,
        country: String?,
        city: String?,
        imageData: Data?
    ) {
        self.id = UUID().uuidString
        self.placeName = placeName
        self.placeDescription = placeDescription
        self.longitude = longitude
        self.latitude = latitude
        self.country = country
        self.city = city
        self.imageData = imageData
    }

    func getAsMKMapItem() -> MKMapItem {
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
