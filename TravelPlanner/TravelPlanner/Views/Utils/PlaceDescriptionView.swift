//
//  PlaceDescriptionView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 11/08/2024.
//

import PhotosUI
import SwiftUI

struct PlaceDescriptionView: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var imageData: Data?

    @FocusState.Binding var isInputActive: Bool

    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        VStack {
            if isInputActive {
                HStack {
                    Spacer()
                    Button("done") {
                        isInputActive = false
                    }
                }
            }

            HStack {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    PlaceImageView(imageData: $imageData)
                        .frame(width: 100)
                        .scaleEffect(2)
                }

                VStack {
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
                        .background(
                            name.isEmpty ? .red : Color("ForegroundColor"))
                }
            }

            TextField("description", text: $description, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .focused($isInputActive)
        }
        .onChange(of: pickerItem) {
            Task {
                if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                    imageData = data
                }
            }
        }
    }
}
