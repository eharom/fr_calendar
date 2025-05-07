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
    var hasReminders = false
    
    var body: some View {
        VStack(spacing: 0.0) {
            monthCard
                .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width < 0.0 {
                            viewModel.addMonthToSelectedMonth()
                        }
                        if value.translation.width > 0.0 {
                            viewModel.removeMonthFromSelectedMonth()
                        }
                    }))
            reminderListCard
        }
    }
    
    var monthCard: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(viewModel.months[viewModel.selectedDate.month - 1].name)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                    .font(.largeTitle)
                Spacer()
                if viewModel.showGregorian {
                    Text(viewModel.selectedDate.toGregorian().string)
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
            }
            .bold()
            
            LazyVGrid(columns: columns, spacing: 0.0) {
                ForEach(0..<numOfDays, id: \.self) { i in
                    Text(daysOfTheWeek[i])
                        .font(.footnote)
                }
            }
            .padding(.horizontal, -10.0)
            .padding(.vertical, 10.0)
            
            MonthGridView(viewModel: viewModel, month: viewModel.months[viewModel.selectedDate.month - 1], numcolumns: numOfDays)
                .padding(.horizontal, -10.0)
        }
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.gray(colorScheme == .light ? 0.93 : 0.14))
            .padding(.all, -15.0))
        .padding(.horizontal, 25.0)
        .padding(.top, 30.0)
    }
    
    var reminderListCard: some View {
        VStack {
            HStack {
                Text("Reminders")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {
                    viewModel.showReminderCreationView = true
                }, label: { Image(systemName: "plus")
                        .foregroundStyle(.blue)
                    .font(.system(size: 25.0))})
                .sheet(isPresented: $viewModel.showReminderCreationView) {
                    ReminderCreationView(viewModel: viewModel)
                }
            }
            .padding(.vertical, 5.0)
            
            if viewModel.dateHasReminders(viewModel.selectedDate, reminders) {
                reminderList
            } else {
                Spacer()
                Text("No Reminders on\n\(viewModel.selectedDate.formatted(.complete))")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .font(.system(size: 20.0, weight: .bold))
                    .padding(.vertical, 5.0)
                if viewModel.showGregorian {
                    Text("\(viewModel.selectedDate.toGregorian().formatted(date: .complete, time: . omitted))")
                        .foregroundStyle(.gray)
                        .font(.system(size: 15.0, weight: .bold))
                }
                Spacer()
            }
            Text("\(viewModel.selectedDate.celebration)")
                .font(.title2)
                .bold()
                .foregroundStyle(.gray)
                .padding(.top, 10.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.gray(colorScheme == .light ? 0.93 : 0.14))
            .padding(.all, -15.0))
        .padding(.horizontal, 25.0)
        .padding(.bottom, 30.0)
        .padding(.top, 45.0)
    }
    var reminderList: some View {
        List {
            Section {
                ForEach(reminders) { reminder in
                    if reminder.date == viewModel.selectedDate {
                        VStack(spacing: 5.0) {
                            HStack(alignment: .top) {
                                Text("\(reminder.title)")
                                    .font(.system(size: 18.0, weight: .bold))
                                    .lineLimit(1)
                                Spacer()
                                Text(reminder.time)
                            }
                            if reminder.show && !reminder.note.isEmpty {
                                HStack(alignment: .top) {
                                    Text(reminder.note)
                                        .font(.system(size: 15.0))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                                .padding(.leading, 15.0)
                            }
                        }
                        .padding(.top, 5.0)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            reminder.show.toggle()
                        }
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        removeReminder(reminders[index])
                    }
                }
            }
            .listRowBackground(colorScheme == .light ? Color.gray(0.93) : Color.gray(0.14))
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
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















//var body: some View {
//    VStack(spacing: 0.0) {
//        VStack(spacing: 10.0) {
//            HStack {
//                Text(viewModel.months[viewModel.selectedDate.month - 1].name)
//                    .font(.largeTitle)
//                    .bold()
//                Spacer()
//                if viewModel.showGregorian {
//                    Text(viewModel.selectedDate.toGregorian().string)
//                        .bold()
//                        .foregroundColor(.gray)
//                        .font(.system(size: 20))
//                }
//            }
//            .padding(.leading, 5.0)
//            LazyVGrid(columns: columns, spacing: 0.0) {
//                ForEach(0..<numOfDays, id: \.self) { i in
//                    Text(daysOfTheWeek[i])
//                        .font(.footnote)
//                }
//            }
//        }
//        .padding(.horizontal, 10.0)
//        .background(colorScheme == .light ? Color.lightGray : .darkGray)
//        
//        GrayDivider()
////            Divider()
//        
//        MonthGridView(viewModel: viewModel, month: viewModel.months[viewModel.selectedDate.month - 1], numcolumns: numOfDays)
//            .padding(.horizontal, 10.0)
//            .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
//                .onEnded({ value in
//                    if value.translation.height < 0.0 {
//                        viewModel.selectedDate.day = 1
//                        if viewModel.selectedDate.month == 13 {
//                            viewModel.selectedDate.month = 1
//                            viewModel.selectedDate.year += 1
//                        } else {
//                            viewModel.selectedDate.month += 1
//                        }
//                    }
//                    if value.translation.height > 0.0 {
//                        viewModel.selectedDate.day = 1
//                        if viewModel.selectedDate.month == 1 {
//                            viewModel.selectedDate.month = 13
//                            viewModel.selectedDate.year -= 1
//                        } else {
//                            viewModel.selectedDate.month -= 1
//                        }
//                    }
//                }))
//        
//        GrayDivider()
////            Divider()
//        
//        List {
//            ForEach(reminders) { reminder in
//                if reminder.date == viewModel.selectedDate {
//                    HStack {
////                            Image(systemName: "circlebadge")
////                                .font(.system(size: 23.0))
//                        Text("\(reminder.title)")
//                            .font(.system(size: 20.0, weight: .bold))
//                            .lineLimit(1)
//                        Spacer()
//                        Text(reminder.time)
//                    }
//                }
//            }
//            .onDelete { indexes in
//                for index in indexes {
//                    removeReminder(reminders[index])
//                }
//            }
//        }
//        .listStyle(.inset)
//        .padding(.top, 20.0)
//        
////
////
////            let selectedDateReminders = reminders.filter { $0.date == viewModel.selectedDate }
////
////            if selectedDateReminders.isEmpty {
////                VStack {
////                    Spacer()
////                    Text("No events")
////                        .font(.title3)
////                        .foregroundStyle(.gray)
////                    Spacer()
////                }
////            } else {
////                List {
////                    ForEach(reminders) { reminder in
////                        HStack {
//////                            Image(systemName: "circlebadge")
//////                                .font(.system(size: 23.0))
////                            Text("\(reminder.title)")
////                                .font(.system(size: 20.0, weight: .bold))
////                                .lineLimit(1)
////                            Spacer()
////                            Text(reminder.time)
////                        }
////                    }
////                    .onDelete { indexes in
////                        for index in indexes {
////                            removeReminder(reminders[index])
////                        }
////                    }
////                }
////                .listStyle(.inset)
////                .padding(.top, 20.0)
////            }
//        
//        HStack {
//            Spacer()
//            Text("\(Initializer.shared.celebrations[viewModel.selectedDate.dayOfYear - 1])")
//                .font(.title2)
//                .bold()
//                .foregroundStyle(.gray)
//                .padding(.top, 10.0)
//            Spacer()
//        }
//        .padding(.bottom, 15.0)
//        Spacer()
//    }
//}
