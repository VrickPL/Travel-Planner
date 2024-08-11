//
//  MarkerViewButtons.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 11/08/2024.
//

import MapKit
import SwiftUI

struct MarkerViewButtons: View {
    @Binding var isPresented: Bool
    let acceptButtonName: String
    let mapItem: MKMapItem
    
    let isAcceptButtonAvailable: () -> Bool
    let onAccept: () -> Void

    var body: some View {
        Button {
            mapItem.openInMaps(launchOptions: nil)
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
                if isAcceptButtonAvailable() {
                    onAccept()
                    isPresented = false
                }
            } label: {
                Text(NSLocalizedString(acceptButtonName, comment: ""))
                    .font(.headline)
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
            }
            .layoutPriority(1)
        }.padding(.vertical)
    }
}
