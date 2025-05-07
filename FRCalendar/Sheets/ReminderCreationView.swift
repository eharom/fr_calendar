//
//  ReminderCreationView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-15.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ReminderCreationView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.modelContext) private var context
    @Query private var reminders: [Reminder]
    
    @State private var dateWasClicked = false
    @State private var timeWasClicked = false
    @State private var endDateWasClicked = false
    
    
    
    @State private var title = ""
    @State private var note = ""
    private var date: FRDate { return FRDate(viewModel.pickerYearStart, viewModel.pickerMonthStart, viewModel.pickerDayStart) }
    private var time: String { return "\(hour):\(minute.padded) \(halfOfDay == 0 ? "a.m." : "p.m.")" }
    private var repeats: Bool { return repetition != "Never" ? true : false }
    @State private var frequency = 2
    @State private var timeUnit = "Day"
    private var repeatsEnds: Bool { return repetitionEnd != "Never" ? true : false }
    @State var timesRepeated = 1
    private var endDate: FRDate { return FRDate(endYear, endMonth, endDay) }
    
    
    
    @State private var repetition = "Never"
    let repetitionOptions = ["Never", "Everyday", "Every week", "Every month", "Every 3 months", "Every 6 months", "Every year", "Personalized"]
    
    @State private var repetitionEnd = "Never"
    let repetitionEndOptions = ["Never", "After repeating", "After a date"]
    
    let repetitionUnits = ["Day", "Week", "Month", "Year"]
    
    var selectedY: Int {
        viewModel.selectedDate.year
    }
    var selectedM: Int {
        viewModel.selectedDate.month
    }
    var selectedD: Int {
        viewModel.selectedDate.day
    }
    
    @State private var selectedCal: FRDatePicker.CalType = .republican
    @State private var endYear = FRDate().year
    @State private var endMonth = FRDate().month
    @State private var endDay = FRDate().day
    @State private var selectedTime: TimePicker.System = .standard
    @State private var hour = 6
    @State private var minute = 30
    @State private var halfOfDay = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section { TextField("Title", text: $title) }
                Section { TextField("Note", text: $note) }
                Section {
                    createSelectorFor("Date")
                    if dateWasClicked {
                        FRDatePicker(type: $selectedCal, year: $viewModel.pickerYearStart, month: $viewModel.pickerMonthStart, day: $viewModel.pickerDayStart)
                    }
                    createSelectorFor("Time")
                    if timeWasClicked {
                        TimePicker(type: $selectedTime, hour: $hour, minute: $minute, timeRange: $halfOfDay)
                    }
                }
//                Section {
//                    List {
//                        ForEach (reminders) { reminder in
//                            VStack(alignment: .leading) {
//                                Text(reminder.title)
//                                    .font(.title3)
//                                Text("Note: \(reminder.note)")
//                                Text("Date: \(reminder.date.longString)")
//                                Text("At: \(reminder.time)")
//                            }
//                        }
//                        .onDelete { indexes in
//                            for index in indexes {
//                                removeReminder(reminders[index])
//                            }
//                        }
//                    }
//                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.showReminderCreationView = false
                    }
                    .foregroundStyle(.blue)
                }
                ToolbarItem(placement: .principal) {
                    Text("New")
                        .bold()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Add") {
                        if title != "" {
                            requestNotificationPermissions()
                            createNotification()
                            addReminder()
                            viewModel.showReminderCreationView = false
                        }
                    }
                    .bold()
                    .foregroundStyle(title != "" ? .blue : .gray)
                }
            }
        }
    }
    
    private func createSelectorFor(_ title: String) -> some View {
        ZStack {
            HStack {
                Image(systemName: title == "Date" ? "calendar" : "clock")
                Text(title)
                Spacer()
                VStack(alignment: .trailing, spacing: 0.0) {
                    if title == "Date" {
                        Text("\(FRDate(viewModel.pickerYearStart, viewModel.pickerMonthStart, viewModel.pickerDayStart).formatted(.complete))")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                        if viewModel.showGregorian {
                            Text("\(FRDate(viewModel.pickerYearStart, viewModel.pickerMonthStart, viewModel.pickerDayStart).toGregorian().formatted(date: .complete, time: .omitted))")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    } else {
                        Text("\(hour):\(minute.padded) \(halfOfDay == 0 ? "a.m." : "p.m.")")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                }
                
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if title == "Date" {
                dateWasClicked.toggle()
                timeWasClicked = false
                endDateWasClicked = false
            } else {
                timeWasClicked.toggle()
                dateWasClicked = false
                endDateWasClicked = false
            }
        }
    }
    
    private func addReminder() {
        let reminder = Reminder(title, note: note, on: date, at: time, repetition: repetition, frequency: frequency, timeUnit, repetitionEnd: repetitionEnd, repeated: timesRepeated, ends: endDate)
        context.insert(reminder)
    }
    
    private func removeReminder(_ reminder: Reminder) {
        context.delete(reminder)
    }
    
    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification permission granted.")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func createNotification() {
        let initialDate = date.toGregorian(hour: hour + (halfOfDay == 1 ? 12 : 0), minute: minute)
        let gDateComponents = Calendar.current.dateComponents(Set(arrayLiteral: Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute), from: initialDate)
        print()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Today, \(time)"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: gDateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        UNUserNotificationCenter.current().add(request)
    }

}









//                Section {
//                    HStack {
//                        Image(systemName: "repeat")
//                        Picker("Repeat", selection: $repetition) {
//                            ForEach(repetitionOptions, id: \.self) {
//                                Text($0)
//                                    .foregroundStyle(.gray)
//                            }
//                        }
//                        .pickerStyle(.navigationLink)
//                    }
//
//                    if repetition == "Personalized" {
//                        Picker("", selection: $timeUnit) {
//                            ForEach(repetitionUnits, id: \.self) {
//                                Text($0)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        Stepper("Every \(frequency) \(timeUnit.lowercased())s", value: $frequency, in: 2...100)
//                    }
//                }
//                if repetition != "Never" {
//                    Picker("End repetition", selection: $repetitionEnd) {
//                        ForEach(repetitionEndOptions, id: \.self) {
//                            Text($0)
//                                .foregroundStyle(.gray)
//                        }
//                    }
//                    .pickerStyle(.navigationLink)
//                    if repetitionEnd == "After repeating"{
//                        Stepper("After repeating \(timesRepeated) time\(timesRepeated == 1 ? "" : "s")", value: $timesRepeated, in: 1...99)
//
//                    }
//                    if repetitionEnd == "After a date"{
//                        ZStack {
//                            HStack {
//                                Text("End after")
//                                Spacer()
//                                VStack(alignment: .trailing, spacing: 0.0) {
//                                    Text("\(FRDate(endYear, endMonth, endDay).longString)")
//                                        .font(.subheadline)
//                                        .foregroundStyle(.red)
//                                    if viewModel.showGregorian {
//                                        Text("\(FRDate(endYear, endMonth, endDay).toGregorian().formatted(date: .complete, time: .omitted))")
//                                            .font(.caption)
//                                            .foregroundStyle(.gray)
//                                    }
//                                }
//
//                            }
//                        }
//                        .contentShape(Rectangle())
//                        .onTapGesture {
//                            endDateWasClicked.toggle()
//                            dateWasClicked = false
//                            timeWasClicked = false
//                        }
//                        if endDateWasClicked {
//                            FRDatePicker(type: $selectedCal, year: $endYear, month: $endMonth, day: $endDay)
//                        }
//                    }
//                }
