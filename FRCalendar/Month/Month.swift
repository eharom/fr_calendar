//
//  Month.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import Foundation

struct Month: Identifiable {
	let id = UUID().uuidString

	var year: Int
	var monthIndex: Int
	var numOfDays: Int
	var days: [Day] = []
	var shortName: String { String(name.prefix(4)) }
	
	init(index: Int, numDays: Int, year: Int) {
		self.year = year
		self.monthIndex = index
		var array = Array<Day>()
		numOfDays = numDays
		for dayIndex in 1..<numOfDays + 1 {
			array.append(Day(year: year, month: monthIndex, day: dayIndex))
		}
		days = array
	}
	
	var name: String {
		switch monthIndex {
		case 1: "Vendimiario"
		case 2: "Brumario"
		case 3: "Frimario"
		case 4: "Nivoso"
		case 5: "Pluvioso"
		case 6: "Ventoso"
		case 7: "Germinal"
		case 8: "Floreal"
		case 9: "Pradial"
		case 10: "Mesidor"
		case 11: "Termidor"
		case 12: "Fructidor"
		case 13: "Sansculottides"
		default: "\(monthIndex)"
		}
	}
	
}
