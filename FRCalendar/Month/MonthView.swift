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

	var body: some View {
		VStack(spacing: 0.0) {
			VStack(spacing: 10.0) {
				HStack {
					Text(viewModel.months[viewModel.selectedDate.month - 1].name)
						.font(.largeTitle)
						.bold()
						.foregroundColor(Color(white: 0.9))
					Spacer()
				}
				.padding(.leading, 5.0)
				LazyVGrid(columns: columns, spacing: 0.0) {
					ForEach(0..<daysOfTheWeek.count, id: \.self) { i in
						Text(daysOfTheWeek[i])
							.font(.footnote)
					}
				}
			}
			.padding(.horizontal, 10.0)
			.foregroundColor(Color(white: 0.9))
			.background(Color(white: 0.1))
			GrayDivider()
			
			VStack {
				MonthGridView(viewModel: viewModel, month: viewModel.months[viewModel.selectedDate.month - 1], numcolumns: 10)
				Spacer()
			}
			.padding(.horizontal, 10.0)
//				.gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
//									.onEnded({ value in
//										if value.translation.height < 0.0 {
//											if viewModel.selectedDate.month == 13{
//												viewModel.selectedDate.month == 1
//												viewModel.selectedDate.year += 1
//											} else {
//												viewModel.selectedDate.month += 1
//											}
//										}
//
//										if value.translation.height > 0.0 {
//											if viewModel.selectedDate.month == 0{
//												viewModel.selectedDate.month == 12
//												viewModel.selectedDate.year -= 1
//											} else {
//												viewModel.selectedDate.month -= 1
//											}
//										}
//									}))
		}
	}
	
	var columns: [GridItem] {
			Array(repeating: GridItem(.flexible(), spacing:0.0), count: 10)
	}
}



#Preview {
	ContentView()
}
