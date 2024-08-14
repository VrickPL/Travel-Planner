//
//  AddMarkerTip.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 13/08/2024.
//

import Foundation
import TipKit

struct AddMarkerTip: Tip {
    var title = Text(LocalizedStringKey("tip_add_marker_title"))
    var message: Text? = Text(LocalizedStringKey("tip_add_marker_message"))
    var image: Image? = Image(systemName: "hand.tap.fill")
}