//
//  FRDate.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-31.
//

import Foundation
import SwiftData

struct FRDate: Equatable, Codable {
    var year: Int = 1
    var month: Int = 1
    var day: Int = 1
    var isLeapYear: Bool { Initializer.shared.leapYears.contains(year) }
    var celebration: String { Initializer.shared.celebrations[FRDate(year, month, day).dayOfYear - 1] }
//    var hour: Int = 0
//    var minute: Int = 0
//    var second: Int = 0
    
    var dayOfYear: Int { (30 * (month - 1)) + day }
    
    var string: String { "\(year.padded)-\(month.padded)-\(day.padded)" }
        
    var dayName: String {
        switch day % 10 {
        case 1: "Primidi"
        case 2: "Duodi"
        case 3: "Tridi"
        case 4: "Quartidi"
        case 5: "Quintidi"
        case 6: "Sextidi"
        case 7: "Septidi"
        case 8: "Octidi"
        case 9: "Nonidi"
        case 0: "Décadi"
        default: "\(day)"
        }
    }
    var monthName: String {
        switch month {
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
        default: "\(month)"
        }
    }
    var sansculottides: String {
        switch day {
        case 1: "Day of Virtue"
        case 2: "Day of Ingenuity"
        case 3: "Day of Labor"
        case 4: "Day of Opinions"
        case 5: "Day of Rewards"
        case 6: "Day of Revolution"
        default: "\(day)"
        }
    }
    
    init(_ y: Int, _ m: Int, _ d: Int, h: Int = 0, min: Int = 0, s: Int = 0) {
        self.year = y
        self.month = m
        self.day = d
//        self.hour = h
//        self.minute = min
//        self.second = s
    }
    
    init() {
        guard let gDate = Date.getCurrentDate() else { return }
        let frDate = gDate.toRepublican()
        self = frDate
    }
    
    func toGregorian(hour: Int = 0, minute: Int = 0) -> Date {
        let leapYears = Initializer.shared.leapYears.filter { $0 < year }.count
        return Calendar(identifier: .iso8601).date(byAdding: DateComponents(calendar: Calendar(identifier: .iso8601), day: ((year - 1)*365 + (month - 1)*30 + (day - 1) + leapYears), hour: hour, minute: minute), to: Date.referenceDate!)!
    }
    
    func formatted(_ format: DateFormat = .numeric) -> String {
        switch format {
        case .complete: "\(dayName), \(monthName) \(day), \(year)"
        case .long: "\(monthName) \(day), \(year)"
        case .abbreviated: "\(monthName.prefix(4)) \(day), \(year)"
        case .numeric: "\(year.padded)-\(month.padded)-\(day.padded)"
        }
    }
    
    enum DateFormat {
        case complete, long, abbreviated, numeric
    }
}

struct Converter {
    static func romanNumeralFor(_ n:Int) -> String {
        guard n > 0 && n < 4000 else { return "Number must be between 1 and 3999" }
        var returnString = ""
        let arabicNumbers = [1000,  900, 500,  400, 100,   90,  50,   40,  10,    9,   5,    4,  1]
        let romanLetters  = [ "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        var num = n
        for (ar, rome) in zip(arabicNumbers, romanLetters) {
            let repeats = num / ar
            returnString += String(repeating: rome, count: repeats)
            num = num % ar
        }
        return returnString
    }
}

class Initializer {
    static let shared = Initializer()
    
    var leapYears: [Int] = []
    var celebrations: [String] = []
    
    private init() {
        if let url = Bundle.main.url(forResource: "frcal_leap", withExtension: "txt"),
           let data = try? Data(contentsOf: url),
           let string = String(data: data, encoding: .utf8) {
            self.leapYears = string.components(separatedBy: "\n").compactMap { Int($0) }
        }
        if let url = Bundle.main.url(forResource: "rural_calendar", withExtension: "txt"),
           let data = try? Data(contentsOf: url),
           let string = String(data: data, encoding: .utf8) {
            self.celebrations = string.components(separatedBy: "\n").compactMap { $0 }
        }
    }
}

