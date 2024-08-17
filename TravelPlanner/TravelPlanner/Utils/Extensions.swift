//
//  Extensions.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 17/08/2024.
//

import Foundation
import SwiftUI

extension Data {
    func asImage() -> Image? {
        guard let uiImage = UIImage(data: self) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
