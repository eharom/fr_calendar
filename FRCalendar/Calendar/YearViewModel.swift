//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

class ViewModel: ObservableObject {
	@Published var currentDate = FRDate()
	@Published var selectedDate = FRDate()
	
	var years: [Int] = []
	
	var year = FRDate().year
	var month = FRDate().month
	var day = FRDate().day
	
	@Published var months: [Month] = []
	@Published var isMonthView = false
	
	init() {
		var array = Array<Month>()
		for i in 1..<14 {
			if i != 13 {
				array.append(Month(index: i, numDays: 30, year: year))
			} else {
				array.append(Month(index: i, numDays: 5, year: year))
			}
		}
		self.months = array
		assert(months.count == 13)
		
		for i in 1...400 {
			years.append(i)
		}
	}
}
















extension YearCalendarView {
	class YearViewModel: ObservableObject {
		var year: Int = 283
		@Published var months: [Month] = []
		@Published var isMonthView = false
		
		init() {
			var array = Array<Month>()
			for i in 1..<14 {
				if i != 13 {
					array.append(Month(index: i, numDays: 30, year: year))
				} else {
					array.append(Month(index: i, numDays: 5, year: year))
				}
			}
			
			self.months = array
			assert(months.count == 13)
		}
	}
}
