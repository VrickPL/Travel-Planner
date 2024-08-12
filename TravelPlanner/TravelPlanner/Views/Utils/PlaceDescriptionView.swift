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

    @FocusState.Binding var isInputActive: Bool

    var body: some View {
        if isInputActive {
            HStack {
                Spacer()
                Button("done") {
                    isInputActive = false
                }
            }
        }

        TextField("name", text: $name, axis: .vertical)
            .font(.title)
            .padding(.top)
            .focused($isInputActive)

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
            .focused($isInputActive)
    }
}
