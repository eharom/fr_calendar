//
//  NewDayView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-03.
//

import SwiftUI
import SwiftData

struct DayCalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Query private var reminders: [Reminder]
    @ObservedObject var viewModel: ViewModel
    let day: Day
    
    var circleColor: Color {
        guard viewModel.dayAndMonthAreEqualToSelectedDay(day) else {
            return .clear
        }
        if viewModel.selectedYearIsCurrentYear() && viewModel.dayAndMonthAreEqualToCurrentDay(day) {
            return .red
        } else {
            return colorScheme == .light ? .black : .white
        }
    }
    
    var textColor: Color {
        guard viewModel.dayAndMonthAreEqualToSelectedDay(day) else {
            if viewModel.selectedYearIsCurrentYear() && viewModel.dayAndMonthAreEqualToCurrentDay(day) {
                return .red
            }
            return day.date.day % 5 == 0 ? .gray : colorScheme == .light ? .black : .white
        }
        if viewModel.selectedYearIsCurrentYear() && viewModel.dayAndMonthAreEqualToCurrentDay(day) {
            return .white
        } else {
            return colorScheme == .light ? .white : .black
        }
    }
    
    var dateHasReminder: Bool {
        for reminder in reminders where reminder.date == FRDate(viewModel.selectedDate.year, viewModel.selectedDate.month, day.date.day) {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            GrayDivider()
//            Divider()
            ZStack {
                Rectangle()
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundStyle(colorScheme == .light ? .white : .black)
                VStack(spacing: 0.0) {
                    ZStack {
                        Circle()
                            .foregroundStyle(circleColor)
                            .frame(maxWidth: viewModel.selectedDate.month == 13 ? 40.0 : 35.0, maxHeight: viewModel.selectedDate.month == 13 ? 40.0 : 35.0)
                        Text("\(day.day)")
                            .foregroundStyle(textColor)
                            .font(.system(size: 20.0))
                            .bold()
                    }
                    Circle()
                        .frame(maxWidth: 7.0, maxHeight: 7.0)
                        .foregroundStyle(dateHasReminder ? .gray : .clear)
                        .padding(.top, 5.0)
                    Spacer()
                }
                .padding(.top, 2.0)
            }
        }
    }
    
    private func dateHasReminders() -> Bool {
        for reminder in reminders where reminder.date == FRDate(viewModel.selectedDate.year, viewModel.selectedDate.month, day.date.day) {
            return true
        }
        return false
    }
}



#Preview {
    ContentView()
}

