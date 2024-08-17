//
//  PlaceImageView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 17/08/2024.
//

import SwiftUI

struct PlaceImageView: View {
    @Binding var imageData: Data?

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 40, height: 40)

            if let image = imageData?.asImage() {
                image
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
            } else {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
        }
        .foregroundStyle(.blue)
    }
}

#Preview {
    PlaceImageView(imageData: .constant(nil))
}
