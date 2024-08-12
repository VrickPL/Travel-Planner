//
//  SinglePlaceView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 12/08/2024.
//

import SwiftUI

struct SinglePlaceView: View {
    @Binding var selectedPlace: MarkerItem?
    @Binding var isNewMarkerSheetEnabled: Bool
    @State var place: MarkerItem

    var body: some View {
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
                isNewMarkerSheetEnabled = true
            } label: {
                SinglePlaceViewWithoutImage(place: place)
            }
            .padding(.vertical, 4)
        }
    }

    private struct SinglePlaceViewWithoutImage: View {
        @State var place: MarkerItem

        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(place.placeName)
                        .font(.callout)
                        .foregroundStyle(Color("ForegroundColor"))

                    HStack {
                        let countryText =
                            place.country?.isEmpty == false
                            ? place.country : nil
                        let cityText =
                            place.city?.isEmpty == false ? place.city : nil

                        Text(
                            "\(countryText ?? "")\(cityText.map { ", \($0)" } ?? "")"
                        )
                    }
                    .font(.caption)
                    .foregroundStyle(.gray)
                }

                Spacer()

                Image(systemName: "pencil")
                    .foregroundStyle(Color("ForegroundColor"))
            }
        }
    }
}

#Preview {
    SinglePlaceView(
        selectedPlace: .constant(nil),
        isNewMarkerSheetEnabled: .constant(false),
        place: MarkerItem(
            placeName: "Apple",
            placeDescription:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la",
            longitude: -122.0090,
            latitude: 37.3349,
            country: "US",
            city: "Cupertino"
        )
    )
}
