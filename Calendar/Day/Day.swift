//
//  Day.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-24.
//

import Foundation

struct Day: Identifiable {
	let id = UUID().uuidString
	
	var month: String
	var isCurrentDate = false
	var frenchDay: Int
	let gregorianDate: String
	
	init(dayNum frenchDay: Int, monthName month: String) {
		gregorianDate = Date().description
		self.frenchDay = frenchDay
		self.month = month
	}
	
	
}
