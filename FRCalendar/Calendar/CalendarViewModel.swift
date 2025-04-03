//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

extension CalendarView {
	class CalendarViewModel: ObservableObject {
		var year: Int = 233
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
