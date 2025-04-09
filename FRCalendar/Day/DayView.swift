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
		if viewModel.selectedDate.month == day.date.month && viewModel.selectedDate.day == day.date.day {
			if viewModel.currentDate == day.date {
				return .red
			} else {
				return Color(white: 0.9)
			}
		}
		return .clear
	}
	var textColor: Color {
		if viewModel.currentDate.month == day.date.month && viewModel.selectedDate.month == day.date.month && viewModel.currentDate.day == day.date.day && viewModel.selectedDate.day == day.date.day {
			return Color(white: 0.9)
		} else if viewModel.currentDate == viewModel.selectedDate{
			return .red
		} else if viewModel.selectedDate.month == day.date.month && viewModel.selectedDate.day == day.date.day {
			return .black
		} else if day.day % 5 == 0 && viewModel.selectedDate.month != 13{
			return Color(white: 0.55)
		}
		return Color(white: 0.9)
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
