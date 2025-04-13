//
//  NewMonthView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-04.
//

import SwiftUI

struct MonthCalendarView: View {
	@ObservedObject var viewModel: ViewModel
	var daysOfTheWeek = ["P", "D", "T", "C", "Q", "S", "S", "O", "N", "D"]
	var numOfDays: Int {
		if viewModel.selectedDate.month == 13 && viewModel.isLeapYear {
			return 6
		} else if viewModel.selectedDate.month == 13 {
			return 5
		}
		return 10
	}

	var body: some View {
		VStack(spacing: 0.0) {
			VStack(spacing: 10.0) {
				HStack {
					Text(viewModel.months[viewModel.selectedDate.month - 1].name)
						.font(.largeTitle)
						.bold()
						.foregroundColor(Color(white: 0.9))
					Spacer()
					Text(viewModel.selectedDate.toGregorian().string)
						.bold()
						.foregroundColor(Color(white: 0.5))
						.font(.system(size: 20))
				}
				.padding(.leading, 5.0)
				LazyVGrid(columns: columns, spacing: 0.0) {
					ForEach(0..<numOfDays, id: \.self) { i in
						Text(daysOfTheWeek[i])
							.font(.footnote)
					}
				}
			}
			.padding(.horizontal, 10.0)
			.foregroundColor(Color(white: 0.9))
			.background(Color(white: 0.1))

			GrayDivider()
			
			MonthGridView(viewModel: viewModel, month: viewModel.months[viewModel.selectedDate.month - 1], numcolumns: numOfDays)
				.padding(.horizontal, 10.0)

			GrayDivider()
			HStack {
				Text("\(Initializer.shared.celebrations[viewModel.selectedDate.dayOfYear - 1])")
					.font(.title2)
					.bold()
					.foregroundStyle(Color(white: 0.4))
					.padding(.top, 10.0)
				Spacer()
			}
			.padding(.horizontal, 15.0)
			Spacer()

		}
	}
	
	var columns: [GridItem] {
			Array(repeating: GridItem(.flexible(), spacing:0.0), count: numOfDays)
	}
}



#Preview {
	ContentView()
}
