//
//  Day.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-24.
//

import Foundation

struct Day: Identifiable {
	let id = UUID().uuidString
	
	var isCurrentDate = false
	let frenchDate: FRDate
	let gregorianDate: Date
	
	init(frenchYear: Int, frenchMonth: Int, frenchDay: Int) {
		frenchDate = FRDate(frenchYear,frenchMonth, frenchDay)
		gregorianDate = frenchDate.toGregorian()
	}
	
	var name: String {
		switch frenchDate.day % 10 {
		case 1: "Primidí"
		case 2: "Duodí"
		case 3: "Tridí"
		case 4: "Cuartidí"
		case 5: "Quintidí"
		case 6: "Sextidí"
		case 7: "Septidí"
		case 8: "Octidí"
		case 9: "Nonidí"
		case 0: "Decadí"
		default: "\(frenchDate.day)"
		}
	}
}
