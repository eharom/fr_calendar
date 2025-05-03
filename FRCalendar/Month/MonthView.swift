//
//  NewMonthView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-04.
//

import SwiftUI
import SwiftData

struct MonthCalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) private var context
    @Query private var reminders: [Reminder]
    
    @ObservedObject var viewModel: ViewModel
    var daysOfTheWeek = ["P", "D", "T", "Q", "Q", "S", "S", "O", "N", "D"]
    var numOfDays: Int {
        if viewModel.selectedDate.month == 13 && viewModel.isLeapYear {
            return 6
        } else if viewModel.selectedDate.month == 13 {
            return 5
        }
        return 10
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 10.0) {
                HStack {
                    Text(viewModel.months[viewModel.selectedDate.month - 1].name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    if viewModel.showGregorian {
                        Text(viewModel.selectedDate.toGregorian().string)
                            .bold()
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                    }
                }
                .padding(.leading, 5.0)
                LazyVGrid(columns: columns, spacing: 0.0) {
                    ForEach(0..<numOfDays, id: \.self) { i in
                        Text(daysOfTheWeek[i])
                            .font(.footnote)
                    }
                }
            }
            .padding(.horizontal, 10.0)
            .background(colorScheme == .light ? Color.lightGray : .darkGray)
            
            GrayDivider()
//            Divider()
            
            MonthGridView(viewModel: viewModel, month: viewModel.months[viewModel.selectedDate.month - 1], numcolumns: numOfDays)
                .padding(.horizontal, 10.0)
                .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.height < 0.0 {
                            viewModel.selectedDate.day = 1
                            if viewModel.selectedDate.month == 13 {
                                viewModel.selectedDate.month = 1
                                viewModel.selectedDate.year += 1
                            } else {
                                viewModel.selectedDate.month += 1
                            }
                        }
                        if value.translation.height > 0.0 {
                            viewModel.selectedDate.day = 1
                            if viewModel.selectedDate.month == 1 {
                                viewModel.selectedDate.month = 13
                                viewModel.selectedDate.year -= 1
                            } else {
                                viewModel.selectedDate.month -= 1
                            }
                        }
                    }))
            
            GrayDivider()
//            Divider()
            
            List {
                ForEach(reminders) { reminder in
                    if reminder.shouldTrigger(on: viewModel.selectedDate) {
                        HStack {
    //                            Image(systemName: "circlebadge")
    //                                .font(.system(size: 23.0))
                            Text("\(reminder.title)")
                                .font(.system(size: 20.0, weight: .bold))
                                .lineLimit(1)
                            Spacer()
                            Text(reminder.time)
                        }
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        removeReminder(reminders[index])
                    }
                }
            }
            .listStyle(.inset)
            .padding(.top, 20.0)
            
//            
//            
//            let selectedDateReminders = reminders.filter { $0.date == viewModel.selectedDate }
//            
//            if selectedDateReminders.isEmpty {
//                VStack {
//                    Spacer()
//                    Text("No events")
//                        .font(.title3)
//                        .foregroundStyle(.gray)
//                    Spacer()
//                }
//            } else {
//                List {
//                    ForEach(reminders) { reminder in
//                        HStack {
////                            Image(systemName: "circlebadge")
////                                .font(.system(size: 23.0))
//                            Text("\(reminder.title)")
//                                .font(.system(size: 20.0, weight: .bold))
//                                .lineLimit(1)
//                            Spacer()
//                            Text(reminder.time)
//                        }
//                    }
//                    .onDelete { indexes in
//                        for index in indexes {
//                            removeReminder(reminders[index])
//                        }
//                    }
//                }
//                .listStyle(.inset)
//                .padding(.top, 20.0)
//            }
            
            HStack {
                Spacer()
                Text("\(Initializer.shared.celebrations[viewModel.selectedDate.dayOfYear - 1])")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.top, 10.0)
                Spacer()
            }
            .padding(.bottom, 15.0)
            Spacer()
        }
    }
    
    var columns: [GridItem] {
            Array(repeating: GridItem(.flexible(), spacing:0.0), count: numOfDays)
    }
    
    private func removeReminder(_ reminder: Reminder) {
        context.delete(reminder)
    }
}

#Preview {
    ContentView()
}

