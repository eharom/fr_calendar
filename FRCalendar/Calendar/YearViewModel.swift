//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var showInfoView = false
    @Published var showConverterView = false
    @Published var showGregorian = false
    @Published var showReminderCreationView = false
    
    @Published var currentDate = FRDate()
    @Published var selectedDate = FRDate()
    @Published var months: [Month] = []
    @Published var isMonthView = false
    @Published var showRomanNumerals = true
    
    let userDefaults = UserDefaults.standard
    let showGregorianKey = "showGregorian"
    let showRomanNumeralsKey = "showRomanNumerals"
    
    @Published var frHours: Int = 0
    @Published var frMinutes: Int = 0
    @Published var frSeconds: Int = 0
    @Published var frMSeconds: Int = 0
    @Published var frTime: String = ""
    
    
    var isLeapYear: Bool {
    Initializer.shared.leapYears.contains(selectedDate.year)
    }
    
    init() {
        var array = Array<Month>()
        for i in 1..<14 {
            if i != 13 {
                array.append(Month(index: i, numDays: 30, year: selectedDate.year))
            } else {
                array.append(Month(index: i, numDays: 6, year: selectedDate.year))
            }
        }
        
        self.months = array
        assert(months.count == 13)
        
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            guard let gDate = Date.getCurrentDate() else { return }
            let frDate = gDate.toRepublican()
            self.currentDate = frDate
        }
        
        if let showRomanNumerals = userDefaults.object(forKey: showRomanNumeralsKey) as? Bool {
            self.showRomanNumerals = showRomanNumerals
        }
        if let showGregorian = userDefaults.object(forKey: showGregorianKey) as? Bool {
            self.showGregorian = showGregorian
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.864, repeats: true) { _ in
            let gMilisTotal = Int(Date().timeIntervalSince1970 * 1000)
            let gMilisToday = gMilisTotal % 86_400_000
            let frMilisToday = Double(gMilisToday) / 0.864
            let localFRTime = Int(frMilisToday + (19.0 * (3600000.0 / 0.864)))
            self.frHours = localFRTime
//            let frMiliseconds = self.frHours % 1000
            self.frHours /= 1000
            let frSeconds = self.frHours % 100
            self.frHours /= 100
            let frMinutes = self.frHours % 100
            self.frHours /= 100
            self.frHours %= 10
            self.frTime = "\(self.frHours):\(frMinutes.padded):\(frSeconds.padded)"//.\(frMiliseconds / 100)"
            
            print(self.frTime)
        }
    }
    
    func dayAndMonthAreEqualToCurrentDay(_ day: Day) -> Bool {
        day.date.day == currentDate.day &&
        day.date.month == currentDate.month
    }
    
    func dayAndMonthAreEqualToSelectedDay(_ day: Day) -> Bool {
        day.date.day == selectedDate.day &&
        day.date.month == selectedDate.month
    }
    
    func selectedYearIsCurrentYear() -> Bool {
        selectedDate.year == currentDate.year
    }
}

extension YearCalendarView {
    class YearViewModel: ObservableObject {
        var year: Int = 283
        @Published var months: [Month] = []
        @Published var isMonthView = false

        init() {
            var array = Array<Month>()
            for i in 1..<14 {
                if i != 13 {
                    array.append(Month(index: i, numDays: 30, year: year))
                } else {
                    array.append(Month(index: i, numDays: 5, year: year))
                }
            }
            self.months = array
            assert(months.count == 13)
        }
    }
}

