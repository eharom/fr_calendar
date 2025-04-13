//
//  CalPicker.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-12.
//

import SwiftUI

struct CalPicker: View {
	@Binding var type: CalType
	@Binding var year: Int 
	@Binding var month: Int
	@Binding var day: Int
	
	let frYearRange = 1..<335
	let gYearRange = 1792..<2127
		
	let frMonthRange = 1..<14
	
	func monthNameForIndex(_ index: Int) -> String {
		if type == .republican {
			switch index {
			case 1: "Vendémiarie"
			case 2: "Brumaire"
			case 3: "Frimaire"
			case 4: "Nivôse"
			case 5: "Pluviôse"
			case 6: "Ventôse"
			case 7: "Germinal"
			case 8: "Floréal"
			case 9: "Prairial"
			case 10: "Messidor"
			case 11: "Thermidor"
			case 12: "Fructidor"
			case 13: "Sansculottides"
			default: "\(index)"
			}
		} else {
			switch index {
			case 1: "January"
			case 2: "February"
			case 3: "March"
			case 4: "April"
			case 5: "May"
			case 6: "June"
			case 7: "July"
			case 8: "August"
			case 9: "September"
			case 10: "October"
			case 11: "November"
			case 12: "December"
			default: "\(index)"
			}
		}
	}
	
//	init(type: CalType, year: Int, month: Int, day: Int) {
//		self.type = type
//		self.year = year
//		self.month = month
//		self.day = day
//	}
	
	var body: some View {
		HStack(spacing: 0.0) {
			Picker(selection: $year, label: Text("Picker"), content: {
				ForEach(type == .republican ? frYearRange : gYearRange, id: \.self) { yIndex in
					Text(verbatim: "\(yIndex)").tag(yIndex)
				}
			})
			.padding(.trailing, -15.0)
			.pickerStyle(WheelPickerStyle())
			.clipped()
			
			Picker(selection: $month, label: Text("Picker"), content: {
				ForEach(type == .republican ? frMonthRange : getGregorianMonthRange(for: year), id: \.self) { mIndex in
					Text("\(monthNameForIndex(mIndex))")
				}
			})
			.padding(.horizontal, -15.0)
			.pickerStyle(WheelPickerStyle())
			.clipped()
			
			Picker(selection: $day, label: Text("Picker"), content: {
				ForEach(getDayRange(for: year, month), id: \.self) { dIndex in
					Text("\(dIndex)").tag(dIndex)
				}
			})
			.padding(.leading, -15.0)
			.pickerStyle(WheelPickerStyle())
			.clipped()
		}
	}
	
	func getGregorianMonthRange(for year: Int) -> Range<Int> {
		if year == 1792 {
			return 9..<13
		} else if year == 2126 {
			return 1..<10
		}
		return 1..<13
	}
	
	func getDayRange(for year: Int, _ month: Int) -> Range<Int> {
		if type == .republican {
			guard month == 13 else { return 1..<31}
			if Initializer.shared.leapYears.contains(year) {
				return 1..<7
			}
			return 1..<6
		} else {
			if year == 1792 && month == 9 {
				return 22..<31
			}
			if year == 2126 && month == 9 {
				return 1..<23
			}
			if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
				return 1..<32
			}
			if month == 2 {
				return Date.isLeapYear(year) ? 1..<30 : 1..<29
			}
			return 1..<31
		}
	}
	
	enum CalType {
		case republican, gregorian
	}
	


}
