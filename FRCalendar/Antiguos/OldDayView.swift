//
//  DayView.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

struct DayView: View {
	let day: Day
	@Binding var selectedDay: Int
	@Binding var isMonthView: Bool
	
	var body: some View {
		ZStack {
			Rectangle()
				.aspectRatio(isMonthView ? 2/3 : 1/1, contentMode: .fit)
				.border(.red)
			VStack(spacing: 0.0) {
				if isMonthView {
//					GrayDivider()
				}
				ZStack {
					Circle()
						.foregroundStyle(selectedDay == day.day ? .white : .black)
					Text("\(day.day)")
						.foregroundStyle(textColor)
						.font(fontSize)
						.bold()
				}
				.padding(.top, isMonthView ? 2.0 : 0.0)
				
				if isMonthView {
					Spacer()
				}
			}
		}
		.if(isMonthView) {
			$0.onTapGesture() {
				selectedDay = day.day
//				print("\(day.name) \(day.frenchDate.date)")
				print(day.gregorian)
				print(Date.now)
			}
		}
	}
	
	var textColor: Color {
		if !isMonthView {
			return .white
		}
		if day.day == selectedDay /*&& !day.isCurrentDate*/{
			return .black
		} else {
			return .white
		}
	}
	
	var fontSize: Font {
		isMonthView ? .title3 : .footnote
	}
}

#Preview {
	YearView()
}
