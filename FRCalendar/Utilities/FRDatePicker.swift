//
//  CalPicker.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-12.
//

import SwiftUI

struct FRDatePicker: View {
    @Binding var type: FRDatePicker.CalType

    @Binding var year: Int
    @Binding var month: Int
    @Binding var day: Int
    
    @State var yearRange: Range<Int> = 1..<335
    @State var monthRange: Range<Int> = 1..<14
    @State var dayRange: Range<Int> = 1..<31
    
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

    var body: some View {
        HStack(spacing: 0.0) {
            Picker(selection: $year, label: Text("Picker"), content: {
                ForEach(yearRange, id: \.self) { yIndex in
                    Text(verbatim: "\(yIndex)").tag(yIndex)
                        .foregroundStyle(.white.opacity(0.9))
                }
            })
            .padding(.trailing, -15.0)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            .onChange(of: year) {
                print("debug: \(year) \(yearRange)")
                updateRangesAndDateComponents()
            }
            
            Picker(selection: $month, label: Text("Picker"), content: {
                ForEach(monthRange, id: \.self) { mIndex in
                    Text("\(monthNameForIndex(mIndex))")
                        .foregroundStyle(.white.opacity(0.9))
                }
            })
            .frame(minWidth: 175.0)
            .padding(.horizontal, -15.0)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            .onChange(of: month) {
                updateRangesAndDateComponents()
            }
            
            Picker(selection: $day, label: Text("Picker"), content: {
                ForEach(dayRange, id: \.self) { dIndex in
                    Text("\(dIndex)").tag(dIndex)
                        .foregroundStyle(.white.opacity(0.9))
                }
            })
            .padding(.leading, -15.0)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            .onChange(of: day) {
                updateRangesAndDateComponents()
            }
        }
        .onChange(of: type) {
//            updateRangesAndDateComponents()
            updateCalendar()
        }
    }
        
    func updateRangesAndDateComponents() {
        updateYearRange()
        updateMonthRange(for: year)
        updateDayRange(for: year, month)
        updateMonth()
        updateDay()
//        self.result = "\(year)-\(month)-\(day)"
        inspectPicker()
    }
    
    func inspectPicker() {
        if year == 25 {
            print("this one")
        }
        print("PICKER: \(type.name), \(year), \(month), \(day)\t\(monthRange), \(dayRange)")
    }

    func updateMonth() {
        if month < monthRange.lowerBound {
            month = monthRange.lowerBound
        }
        if month >= monthRange.upperBound {
            month = monthRange.upperBound - 1
        }
    }
    
    func updateDay() {
        if day < dayRange.lowerBound {
            day = dayRange.lowerBound
        }
        if day >= dayRange.upperBound {
            day = dayRange.upperBound - 1
        }
    }
    
    func updateCalendar() {
        if type == .republican {
            year = FRDate().year
            month = FRDate().month
            day = FRDate().day
        } else {
            year = Date.getCurrentYear()!
            month = Date.getCurrentMonth()!
            day = Date.getCurrentDay()!
        }
    }
    
    func updateYearRange() {
        yearRange = type == .republican ? 1..<335 : 1792..<2127
    }
    
    func updateMonthRange(for year: Int) {
        if type == .gregorian {
            if year == 1792 {
                monthRange = 9..<13
                return
            } else if year == 2126 {
                monthRange = 1..<10
                return
            }
            monthRange = 1..<13
            return
        } else {
            monthRange = 1..<14
            return
        }
    }
    
    func updateDayRange(for year: Int, _ month: Int) {
        if type == .republican {
            guard month == 13 else {
                dayRange = 1..<31
                return
            }
            if Initializer.shared.leapYears.contains(year) {
                dayRange = 1..<7
                return
            }
            dayRange = 1..<6
            return
        } else {
            if year == 1792 && month == 9 {
                dayRange = 22..<31
                return
            }
            if year == 2126 && month == 9 {
                dayRange =  1..<23
                return
            }
            if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
                dayRange = 1..<32
                return
            }
            if month == 2 {
                dayRange = Date.isLeapYear(year) ? 1..<30 : 1..<29
                return
            }
            dayRange = 1..<31
            return
        }
    }
    
    enum CalType {
        case republican, gregorian
        var name: String {
            "\(self)"
        }
    }
}

