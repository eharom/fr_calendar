//
//  Month.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import Foundation

struct Month: Identifiable {
    let id = UUID().uuidString

    var year: Int
    var monthIndex: Int
    var numOfDays: Int
    var days: [Day] = []
    var shortName: String { String(name.prefix(4)) }
    
    init(index: Int, numDays: Int, year: Int) {
        self.year = year
        self.monthIndex = index
        var array = Array<Day>()
        numOfDays = numDays
        for dayIndex in 1..<numOfDays + 1 {
            array.append(Day(year: year, month: monthIndex, day: dayIndex))
        }
        days = array
    }
    
    var name: String {
        switch monthIndex {
        case 1: "Vendémiaire"
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
        default: "\(monthIndex)"
        }
    }
    var season: String {
        switch monthIndex {
        case 1...3: "Autumn"
        case 4...6: "Winter"
        case 7...9: "Spring"
        case 10...12: "Summer"
        default: "\(monthIndex)"
        }
    }
    
    var seasonLogo: String {
        switch monthIndex {
        case 1...3: "leaf"
        case 4...6: "snowflake"
        case 7...9: "ladybug"
        case 10...12: "sun.max.fill"
        default: "\(monthIndex)"
        }
    }
    
}

