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
	var isLeapYear: Bool {
		Initializer.shared.leapYears.contains(selectedDate.year)
	}
	
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
				array.append(Month(index: i, numDays: 6, year: year))
			}
		}
		self.months = array
		assert(months.count == 13)
	}
	
	func dayAndMonthAreEqualToCurrentDay(_ day: Day) -> Bool {
		day.date.day == currentDate.day &&
		day.date.month == currentDate.month
	}
	
	func dayAndMonthAreEqualToSelectedDay(_ day: Day) -> Bool {
		day.date.day == selectedDate.day &&
		day.date.month == selectedDate.month
	}
	
	func selectedYearIsCurrentYear() -> Bool {
		selectedDate.year == currentDate.year
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
