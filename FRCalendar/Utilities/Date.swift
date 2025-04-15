//
//  Date.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-04-02.
//

import Foundation

extension Date {
    static func getMonthName(for month: Int) -> String {
        switch month {
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
        default: "\(month)"
        }
    }
    
    static func isLeapYear(_ targetYear: Int) -> Bool {
        if targetYear % 400 == 0 { return true }
        if targetYear % 100 == 0 { return false }
        if targetYear % 4 == 0 { return true }
        return false
    }

    static let referenceDate = Date.from(string: "1792-09-22")
    var string: String {
      String("\(self)".prefix(10))
    }
  
    static func getCurrentDate() -> Date? {
        let components = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
        guard let year = components.year, let month = components.month, let day = components.day else {return nil }
        let dateString = "\(year)-\(month)-\(day)"
        return Date.from(string: dateString)
    }
  
    static func getCurrentYear() -> Int? {
      let components = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
        guard let year = components.year else { return nil }
        return year
    }
  
    static func getCurrentMonth() -> Int? {
        let components = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
        guard let month = components.month else { return nil }
        return month
    }
    
    static func getCurrentDay() -> Int? {
        let components = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
        guard let day = components.day else { return nil }
        return day
    }
  
    func toRepublican() -> FRDate {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let rangeStart = dateComponents.year! - 1792
        let rangeEnd = rangeStart + (dateComponents.month! > 8 ? 1 : 0)
      
        var numOfDays = 30
      
        var startingMonth: Int {
          guard let month = dateComponents.month else { return 0 }
          return switch month {
            case 1...9: month + 3
            case 10...12: month - 9
            default: 0
          }
        }
  
  var start = startingMonth

  for y in rangeStart...rangeEnd {
    let isLeapYear = Initializer.shared.leapYears.contains(y)
    for m in start...13 {
      if m == 13 && isLeapYear { numOfDays = 6
      } else if m == 13 && !isLeapYear {
        numOfDays = 5
      } else {
        numOfDays = 30
      }
      for d in 1...numOfDays where FRDate(y, m, d).toGregorian().string == self.string {
        return FRDate(y, m, d)
      }
    }
    
    start = 1
  }
  return FRDate(1, 1, 1)
  }
    
    var daysSinceReferenceDay: Int {
        guard let date = Date.referenceDate else { return 0 }
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    static func from(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        return dateFormatter.date(from: string)
    }

    static func createDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
        var components = DateComponents()
        components.calendar = Calendar(identifier: .iso8601)
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
    
    func toRepublican2() -> FRDate {
        let days = self.daysSinceReferenceDay
        let year = days / 365
        let leapYears = Initializer.shared.leapYears.filter { $0 <= Int(year) }.count
        let month = days % 365 / 30
        let day = days - year * 365 - month * 30

        var rYear = year + 1
        var rMonth = month + 1
        var rDay = day + 1 - leapYears
        if rDay <= 0 {
            let delta = abs(rDay)
            // print("Date: DELTA \(delta)")
            rYear -= 1
            rMonth = 13
            rDay = 6 - delta
        }
        return FRDate(rYear, rMonth, rDay)
    }
}

