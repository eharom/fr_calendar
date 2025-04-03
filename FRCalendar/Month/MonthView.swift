//
//  MonthView.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

struct MonthView: View {
	let month: Month
	@State var selectorColor: Color = .red
	@State var selectedDay = 31
	@Binding var isMonthView: Bool

	var body: some View {
		VStack(alignment: .leading, spacing: 0.0) {
			if !isMonthView {
				Text(month.shortName)
					.foregroundStyle(.white)
					.font(.title)
					.bold()
					.background(Color.black)
						}
			monthCardBody
				.onTapGesture {
					if !isMonthView {
						isMonthView.toggle()
					}
				}
				.padding(.top, isMonthView ? 00.0 : 10.0)
		}
		.padding(.bottom, isMonthView ? 0.0 : 40.0)
		.background(Color.black)
	}
	
	var monthCardBody: some View {
		VStack(alignment: .leading, spacing: 0.0){
			LazyVGrid(columns: getColumns(), spacing: 0.0) {
				ForEach(0..<month.numOfDays, id: \.self) { i in
					DayView(day: month.days[i], selectedDay: $selectedDay, isMonthView: $isMonthView)
				}
			}
		}
	}
	
	var extraDaysCards: some View {
		HStack(spacing: 0.0) {
			ForEach(0..<5, id: \.self) { i in
				VStack(spacing: 0.0) {
					DayView(day: month.days[12], selectedDay: $selectedDay, isMonthView: $isMonthView)
				}
			}
		}
	}
	
	func getColumns() -> [GridItem] {
		return Array(repeating: GridItem(.flexible(), spacing: 0.0), count: isMonthView ? 10 : 5)
	}
	
}

//struct ExtraDaysCardView: View {
//	var
//	var body: some View {
//		HStack(spacing: 0.0) {
//			ForEach(0..<5, id: \.self) { i in
//				VStack(spacing: 0.0) {
//					DayView(day: month.days[12], selectedDay: $selectedDay, isMonthView: $isMonthView)
//				}
//			}
//		}
//	}
//}

#Preview {
	CalendarView()
}
