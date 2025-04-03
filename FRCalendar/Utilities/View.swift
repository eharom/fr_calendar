//
//  View.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-24.
//

import SwiftUI

extension View {
	@ViewBuilder func `if` <Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
		if condition() {
			transform(self)
		} else {
			self
		}
	}
}

extension Int {
	var padded: String {
		String(format: "%02d", self)
	}
}
