//
//  NewDayView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-03.
//

import SwiftUI

struct DayCalendarView: View {
	@ObservedObject var viewModel: ViewModel
	let day: Day
	
	var circleColor: Color {
		guard viewModel.dayAndMonthAreEqualToSelectedDay(day) else {
			return .clear
		}
		if viewModel.selectedYearIsCurrentYear() && viewModel.dayAndMonthAreEqualToCurrentDay(day) {
			return .red
		} else {
			return Color(white: 0.9)
		}
	}
	
	var textColor: Color {
		guard viewModel.dayAndMonthAreEqualToSelectedDay(day) else {
			if viewModel.selectedYearIsCurrentYear() && viewModel.dayAndMonthAreEqualToCurrentDay(day) {
				return .red
			}
			return Color(white: day.date.day % 5 == 0 ? 0.55 : 0.9)
		}
		if viewModel.selectedYearIsCurrentYear() && viewModel.dayAndMonthAreEqualToCurrentDay(day) {
			return Color(white: 0.9)
		} else {
			return .black
		}
	}
	
	var body: some View {
		VStack(spacing: 0.0) {
			GrayDivider()
			ZStack {
				Rectangle()
					.aspectRatio(2/3, contentMode: .fit)
					.foregroundStyle(.black)
				VStack {
					ZStack {
						Circle()
							.foregroundStyle(circleColor)
							.frame(maxWidth: viewModel.selectedDate.month == 13 ? 40 : nil, maxHeight: viewModel.selectedDate.month == 13 ? 40 : nil)
						Text("\(day.day)")
							.foregroundStyle(textColor)
							.font(.system(size: 20.0))
							.bold()
					}
					Spacer()
				}
				.padding(.top, 2.0)
			}
		}
	}
}



#Preview {
	ContentView()
}
