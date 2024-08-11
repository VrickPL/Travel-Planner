//
//  PlacesToVisitListView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 07/08/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct PlacesToVisitListView: View {
    @Environment(\.modelContext) private var context

    @Query private var placesToVisit: [MarkerItem]
    @State private var selectedPlace: MarkerItem?

    @State private var isNewMarketSheetEnabled = false

    var body: some View {
        NavigationView {
            List {
                ForEach(placesToVisit) { place in
                    HStack {
                        Button {
                            //TODO: fix clicking on button and load photo from gallery
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                        }
                        .foregroundStyle(.blue)
                        .padding(.trailing, 8)
                        
                        Button {
                            selectedPlace = place
                            isNewMarketSheetEnabled = true
                        } label: {
                            SinglePlaceToVisit(place: place)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteMarker(placesToVisit[index])
                    }
                }
            }
            .navigationBarItems(
                trailing: NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
            )
            .onChange(of: selectedPlace) {}
            .sheet(
                isPresented: $isNewMarketSheetEnabled,
                onDismiss: {
                    isNewMarketSheetEnabled = false
                }
            ) {
                if let selectedPlace = selectedPlace {
                    EditMarkerView(
                        markerItem: selectedPlace,
                        isPresented: $isNewMarketSheetEnabled
                    )
                    .padding()
                }
            }
        }
    }

    func deleteMarker(_ markerItem: MarkerItem) {
        context.delete(markerItem)
    }
}

#Preview {
    PlacesToVisitListView()
}
