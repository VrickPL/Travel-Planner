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
    var acceptButtonColor: Color = .blue
    var declineButtonName: String = "cancel"
    var declineButtonColor: Color = .gray
    let mapItem: MKMapItem
    
    let isAcceptButtonAvailable: () -> Bool
    let onAccept: () -> Void
    var onDecline: () -> Void

    var body: some View {
        AppleMapsButton(item: mapItem)

        HStack {
            Button {
                onDecline()
                isPresented = false
            } label: {
                Text(NSLocalizedString(declineButtonName, comment: ""))
                    .font(.headline)
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(declineButtonColor)
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
                    .background(acceptButtonColor)
                    .cornerRadius(15)
            }
            .layoutPriority(1)
        }.padding(.vertical)
    }
}
