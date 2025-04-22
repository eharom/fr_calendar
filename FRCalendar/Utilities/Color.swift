//
//  Color.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-21.
//

import SwiftUI


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static let darkGray = Color(red: 0.10, green: 0.10, blue: 0.10)
    static let lightGray = Color(red: 0.96, green: 0.96, blue: 0.96)
}
