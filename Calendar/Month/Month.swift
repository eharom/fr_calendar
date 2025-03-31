//
//  Month.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import Foundation

struct Month: Identifiable {
	var numOfDays: Int
	let id = UUID().uuidString
	var days: [Day] = []
	var index: Int
	var iscurrentMonth = false
	var isSpecial = false
	
	init(index: Int, numDays: Int) {
		self.index = index
		var array = Array<Day>()
		numOfDays = numDays
		for i in 1..<numOfDays + 1 {
			array.append(Day(dayNum: i, monthName: name))
		}
		days = array
	}
	
	var name: String {
		switch index {
		case 0: "Vendimiario"
		case 1: "Brumario"
		case 2: "Frimario"
		case 3: "Nivoso"
		case 4: "Pluvioso"
		case 5: "Ventoso"
		case 6: "Germinal"
		case 7: "Floreal"
		case 8: "Pradial"
		case 9: "Mesidor"
		case 10: "Termidor"
		case 11: "Fructidor"
		default: "\(index)"
		}
	}
	
	var shortName: String {
		String(name.prefix(4))
	}
}
