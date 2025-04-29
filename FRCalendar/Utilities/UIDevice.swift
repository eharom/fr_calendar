//
//  UIDevice.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-14.
//

import UIKit

extension UIDevice {
    static var smallScreen: Bool {
        UIDevice.current.name.contains("SE") || UIDevice.current.name.contains("iPad")
    }
}
