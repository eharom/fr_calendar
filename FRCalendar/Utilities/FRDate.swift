//
//  FRDate.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-31.
//

import Foundation

struct FRDate: Equatable {
	var year: Int
	var month: Int
	var day: Int
	
    var string: String { "\(year.padded)-\(month.padded)-\(day.padded)" }

	var gregorian: Date {
		let leapYears = Initializer.shared.leapYears.filter { $0 < year }.count
		return Calendar(identifier: .iso8601).date(byAdding: DateComponents(calendar: Calendar(identifier: .iso8601), day: ((year - 1)*365 + (month - 1)*30 + (day - 1) + leapYears)), to: Date.referenceDate!)!
	}
	
	init(_ y: Int, _ m: Int, _ d: Int) {
		self.year = y
		self.month = m
		self.day = d
	}
	
	init() {		
		let today = Date().toRepublican()
		self.year = today.year
		self.month = today.month
		self.day = today.day
	}

	
	func toGregorian() -> Date {
		let leapYears = Initializer.shared.leapYears.filter { $0 < year }.count
		return Calendar(identifier: .iso8601).date(byAdding: DateComponents(calendar: Calendar(identifier: .iso8601), day: ((year - 1)*365 + (month - 1)*30 + (day - 1) + leapYears)), to: Date.referenceDate!)!
	}
}

struct Converter {
	static func romanNumeralFor(_ n:Int) -> String {
		guard n > 0 && n < 4000 else { return "Number must be between 1 and 3999" }
		var returnString = ""
		let arabicNumbers = [1000,  900, 500,  400, 100,   90,  50,   40,  10,    9,   5,    4,  1]
		let romanLetters  = [ "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
		var num = n
		for (ar, rome) in zip(arabicNumbers, romanLetters) {
			let repeats = num / ar
			returnString += String(repeating: rome, count: repeats)
			num = num % ar
		}
		return returnString
	}
}


class Initializer {
	static let shared = Initializer()
	
	var leapYears: [Int] = []
	
	private init() {
		if let url = Bundle.main.url(forResource: "frcal_leap", withExtension: "txt"),
		   let data = try? Data(contentsOf: url),
		   let string = String(data: data, encoding: .utf8) {
			self.leapYears = string.components(separatedBy: "\n").compactMap { Int($0) }
		}
	}
}
