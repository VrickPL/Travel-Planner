//
//  Theme.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 10/08/2024.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable {
    case systemDefault = "auto"
    case light = "light"
    case dark = "dark"

    var colorScheme: ColorScheme? {
        return switch self {
        case .systemDefault:
            nil
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}
