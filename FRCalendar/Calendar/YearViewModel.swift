//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI
import SwiftData

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
    
    @Published var pickerYearStart = 0
    @Published var pickerMonthStart = 0
    @Published var pickerDayStart = 0
    
    let userDefaults = UserDefaults.standard
    let showGregorianKey = "showGregorian"
    let showRomanNumeralsKey = "showRomanNumerals"
    
    @Query private var reminders: [Reminder]
    
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
        
        updatePickerDates()

    }
    
    func addMonthToSelectedMonth() {
        if selectedDate.month == 13 {
            if selectedDate.year < 334 {
                selectedDate.month = 1
                selectedDate.year += 1
                selectedDate.day = 1
            }
        } else {
            selectedDate.month += 1
            selectedDate.day = 1
        }
    }
    func removeMonthFromSelectedMonth() {
        if selectedDate.month == 1 {
            if selectedDate.year > 1 {
                selectedDate.month = 13
                selectedDate.year -= 1
                selectedDate.day = 1
            }
        } else {
            selectedDate.month -= 1
            selectedDate.day = 1
        }
    }
    func dateHasReminders(_ date: FRDate, _ reminders: [Reminder]) -> Bool {
        for reminder in reminders {
            if reminder.date == date {
                return true
            }
        }
        return false
    }
    
    func updatePickerDates() {
        pickerYearStart = selectedDate.year
        pickerMonthStart = selectedDate.month
        pickerDayStart = selectedDate.day
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

