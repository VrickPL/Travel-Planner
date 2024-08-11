//
//  PlaceDescriptionView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 11/08/2024.
//

import SwiftUI

struct PlaceDescriptionView: View {    
    @Binding var name: String
    @Binding var description: String

    var body: some View {
        TextField("name", text: $name, axis: .vertical)
            .font(.title)
            .padding(.top)

        if name.isEmpty {
            HStack {
                Text("name_is_empty")
                    .font(.caption)
                    .foregroundColor(.red)

                Spacer()
            }
        }
        Divider()
            .background(name.isEmpty ? .red : Color("ForegroundColor"))

        TextField("description", text: $description, axis: .vertical)
            .textFieldStyle(.roundedBorder)
            .padding(.vertical)
    }
}

#Preview {
    PlaceDescriptionView(
        name: .constant("Apple"),
        description: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la")
    )
}
