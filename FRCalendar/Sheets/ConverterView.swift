//
//  ConverterView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-12.
//

import SwiftUI

struct ConverterView: View {
	@State var year: Int = FRDate().year
	@State var month: Int = FRDate().month
	@State var day: Int = FRDate().day
	
	var result: String {
		if selectedCal == .republican {
			"\(FRDate(year, month, day).toGregorian())"
		} else {
			"\(Date.from(string: "\(year)-\(month)-\(day)")!.toRepublican().longString)"
		}
	}
	@State var selectedCal: CalPicker.CalType = .republican
	
	var body: some View {
		ZStack {
			Rectangle()
				.foregroundStyle(Color.black.opacity(0.2))
			VStack(spacing: 25.0) {
				HStack {
					Text("Convert to \(selectedCal == .republican ? "Gregorian" : "Republican")")
						.font(.system(size: 25.0, weight: .bold, design: .default))
						.foregroundStyle(.white.opacity(0.9))
					Spacer()
				}
				.padding(.horizontal, 10.0)
				
				HStack {
					Text(result)
					Spacer()
				}
				.padding(.horizontal, 10.0)
				.font(.system(size: 20.0))
				.foregroundStyle(.white.opacity(0.9))

				CalPicker(type: $selectedCal, year: $year, month: $month, day: $day)
					.background(Color.white.opacity(0.05))
					.cornerRadius(20.0)
				
				HStack {
					Button(action: {
						if selectedCal == .republican {
							selectedCal = .gregorian
						} else {
							selectedCal = .republican
						}
					}, label: {
						Image(systemName: "calendar")
							.foregroundStyle(.white.opacity(0.3))
							.font(.title2)
					})
					.padding(.leading, 10.0)
					
					Spacer()
					
					Button(action: {
//						print(pickerYear, pickerMonth, pickerDay)
					}, label: {
						Image(systemName: "arrowshape.right.circle.fill")
							.foregroundStyle(.white.opacity(0.3))
							.font(.title2)
					})
					.padding(.trailing, 10.0)
				}
				Spacer()
			}
			.padding(.horizontal, 10.0)
			.padding(.top, 25.0)
		}
		.ignoresSafeArea()
	}
}
