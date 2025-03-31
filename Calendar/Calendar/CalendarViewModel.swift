//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

extension CalendarView {
	class CalendarViewModel: ObservableObject {
		var calendar = Calendar(identifier: .iso8601)
		var start = DateComponents(calendar: Calendar(identifier: .iso8601), year: 1792, month: 9, day: 22)
		
		var startDate: Date! {
			Calendar(identifier: .iso8601).date(from: start)
		}
		
		var oneYearLater: Date! {
			Calendar(identifier: .iso8601).date(byAdding: DateComponents(calendar: Calendar(identifier: .iso8601), day: 365), to: startDate)
		}
		
		
		@Published var months: [Month] = []
		@Published var isMonthView = false
		
		init() {
			var array = Array<Month>()
			for i in 0..<13 {
				if i != 12 {
					array.append(Month(index: i, numDays: 30))
				} else {
					array.append(Month(index: i, numDays: 5))
				}
			}
			
			self.months = array
			assert(months.count == 13)
		}
	}
}
