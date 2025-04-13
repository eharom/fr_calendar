//
//  ConverterView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-12.
//

import SwiftUI

struct ConverterView: View {
	@State var pickerYear = FRDate().year {
		didSet {
			print("Year changed")
			resetDisplayDate()
		}
	}
	@State var pickerMonth = FRDate().month {
		didSet {
			print("Month changed")
			resetDisplayDate()
		}
	}
	@State var pickerDay = FRDate().day {
		didSet {
			print("Day changed")
			resetDisplayDate()
		}
	}
	
	func resetDisplayDate() {
		print(pickerYear, pickerMonth, pickerDay)
		if selectedCal == .republican {
			dateText = "\(FRDate(pickerYear, pickerMonth, pickerDay).toGregorian())"
		}
		if let date = Date.from(string: "\(pickerYear)-\(pickerMonth)-\(pickerDay)") {
			dateText = "\(date.toRepublican().longString)"
		} else {
			print("ERROR: Invalid Date String")
		}
	}
	
	
	@State var dateText = FRDate().longString
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
					Text(dateText)
					Spacer()
				}
				.padding(.horizontal, 10.0)
				.font(.system(size: 20.0))
				.foregroundStyle(.white.opacity(0.9))

				CalPicker(type: $selectedCal, year: $pickerYear, month: $pickerMonth, day: $pickerDay)
					.background(Color.white.opacity(0.05))
					.cornerRadius(20.0)
				
				HStack {
					Button(action: {
						if selectedCal == .republican {
							selectedCal = .gregorian
							pickerYear = Date.getCurrentYear()!
							pickerMonth = Date.getCurrentMonth()!
							pickerDay = Date.getCurrentDay()!
						} else {
							selectedCal = .republican
							pickerYear = FRDate().year
							pickerMonth = FRDate().month
							pickerDay = FRDate().day
						}
					}, label: {
						Image(systemName: "calendar")
							.foregroundStyle(.white.opacity(0.3))
							.font(.title2)
					})
					.padding(.leading, 10.0)
					
					Spacer()
					
					Button(action: {
						print(pickerYear, pickerMonth, pickerDay)
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
