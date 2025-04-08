//
//  MonthCardView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-03.
//

import SwiftUI

struct MonthGridView: View {
	@ObservedObject var viewModel: ViewModel
	
	let month: Month
	let numcolumns: Int
	var body: some View {
		LazyVGrid(columns: columns, spacing: 0.0) {
			ForEach(0..<month.numOfDays, id: \.self) { i in
				DayCalendarView(viewModel: viewModel, day: month.days[i])
					.onTapGesture {
						viewModel.selectedDate.day = i + 1
						print("\(DayCalendarView(viewModel: viewModel, day: month.days[i]).day.date)")
					}
			}
		}
	}
	var columns: [GridItem] {
		Array(repeating: GridItem(.flexible(), spacing: 0.0), count: numcolumns)
	}
}

#Preview {
	ContentView()
}
