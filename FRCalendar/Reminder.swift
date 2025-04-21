//
//  Reminder.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-17.
//

import Foundation
import SwiftData

@Model class Reminder: Identifiable {
    var id: String

    var title: String
    var note: String
    var date: FRDate
    var time: String
    var repetition: String
    var frequency: Int
    var timeUnit: String
    var repetitionEnd: String
    var timesRepeated: Int
    var endDate: FRDate

    var isActive = false

    init(_ title: String, note: String, on date: FRDate, at time: String, repetition: String, frequency: Int, _ timeUnit: String, repetitionEnd: String, repeated timesRepeated: Int, ends endDate: FRDate) {
        self.id = UUID().uuidString
        self.title = title
        self.note = note
        self.date = date
        self.time = time
        self.repetition = repetition
        self.frequency = frequency
        self.timeUnit = "\(timeUnit)\(frequency == 1 ? "" : "s")"
        self.repetitionEnd = repetitionEnd
        self.timesRepeated = timesRepeated
        self.endDate = endDate
        
        if repetition != "Never" {
            if repetition == "Everyday" {
                self.frequency = 1
                self.timeUnit = "day"
            }
            if repetition == "Every week" {
                self.frequency = 1
                self.timeUnit = "week"
            }
            if repetition == "Every month" {
                self.frequency = 1
                self.timeUnit = "month"
            }
            if repetition == "Every 3 months" {
                self.frequency = 3
                self.timeUnit = "months"
            }
            if repetition == "Every 6 months" {
                self.frequency = 6
                self.timeUnit = "months"
            }
            if repetition == "Every year" {
                self.frequency = 1
                self.timeUnit = "year"
            }
        }
    }
}
