//
//  PlacesToVisitViewModel.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 12/08/2024.
//

import Combine
import SwiftUI

@Observable
class PlacesToVisitViewModel {
    var names: [String] = []
    var markersByName: [String: [MarkerItem]] = [:]

    func updateMarkersByName(placesToVisit: [MarkerItem], selectedFilter: FilterOption) {
        var newNames: Set<String> = []
        var newMarkersByName: [String: [MarkerItem]] = [:]

        for place in placesToVisit {
            let name: String
            switch selectedFilter {
            case .country:
                name = place.country ?? "unknown_country"
            case .city:
                name = place.city ?? "unknown_city"
            case .all:
                name = ""
            }

            newNames.insert(name)
            newMarkersByName[name, default: []].append(place)
        }

        names = Array(newNames).sorted()
        markersByName = newMarkersByName
    }
}
