//
//  FilteredListOfPlacesView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 12/08/2024.
//

import SwiftUI

struct FilteredListOfPlacesView: View {
    @Binding var names: [String]
    @Binding var markersByName: [String: [MarkerItem]]
    @Binding var shouldBeRefreshed: Bool

    @State private var isListExpanded = false
    @State private var nameOfExpandedList: String?

    var body: some View {
        VStack {
            ForEach(names, id: \.self) { name in
                Button {
                    if nameOfExpandedList == name {
                        isListExpanded = false
                        nameOfExpandedList = nil
                    } else {
                        isListExpanded = false
                        nameOfExpandedList = name
                        isListExpanded = true
                    }
                } label: {
                    VStack {
                        Divider()
                            .background(Color("ForegroundColor"))

                        HStack {
                            Text(name)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .rotationEffect(
                                    isListExpanded
                                        && nameOfExpandedList == name
                                        ? .degrees(90) : .degrees(0)
                                )
                                .animation(
                                    .bouncy,
                                    value: isListExpanded
                                        && nameOfExpandedList == name
                                )
                        }
                        .tint(
                            isListExpanded && nameOfExpandedList == name
                            ? .blue : Color("ForegroundColor")
                        )
                        .padding()
                        .cornerRadius(15)
                    }
                }

                if isListExpanded && nameOfExpandedList == name {
                    ListOfPlacesView(
                        placesToVisit: markersByName[name]!,
                        shouldBeCustom: true
                    )
                }
            }

            Divider()
                .background(Color("ForegroundColor"))
        }
        .onChange(of: names) {
            clearExpandedList()
        }
        .onChange(of: shouldBeRefreshed) {
            if shouldBeRefreshed {
                clearExpandedList()
                shouldBeRefreshed = false
            }
        }
    }

    private func clearExpandedList() {
        isListExpanded = false
        nameOfExpandedList = nil
    }
}
