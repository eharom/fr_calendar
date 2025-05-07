//
//  NewYear.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-03.
//

import SwiftUI

struct YearCalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
            VStack(spacing: 0.0) {
                
                //            Year header
//                HStack {
//                    Text(viewModel.showRomanNumerals ? "\(viewModel.selectedDate.year)" : "\(Converter.romanNumeralFor(viewModel.selectedDate.year))")
//                        .bold()
//                        .font(.largeTitle)
//                        .foregroundStyle(viewModel.selectedDate.year == viewModel.currentDate.year ? .red : colorScheme == .light ? .black : .white)
//                        .onTapGesture {
//                            viewModel.showRomanNumerals.toggle()
//                            viewModel.userDefaults.set(viewModel.showRomanNumerals, forKey: viewModel.showRomanNumeralsKey)
//                        }
//                    Spacer()
//                    if viewModel.showGregorian {
//                        Text(verbatim: "\(viewModel.selectedDate.year + 1791) - \(viewModel.selectedDate.year + 1792)")
//                            .bold()
//                            .font(.title3)
//                            .foregroundStyle(.gray)
//                    }
//                }
//                .padding(.vertical, UIDevice.smallScreen ? 0.0 : 5.0)
                
//                Divider().padding(.bottom, 10.0)
//                GrayDivider().padding(.bottom, UIDevice.smallScreen ? 0.0 : 10.0)
                //            Mini month cards for months 1 - 12
                LazyVGrid(columns: columns, spacing: UIDevice.smallScreen ? 5.0 : 15.0) {
                    ForEach(1..<13) { i in
                        MiniMonthView(viewModel: viewModel, monthIndex: i)
                            .padding(.all, 5.0)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(monthBackgroundColor))
                            .onTapGesture {
                                viewModel.isMonthView = true
                                viewModel.selectedDate.month = i
                                viewModel.selectedDate.day = 1
                                viewModel.updatePickerDates()
                            }
                    }
                }
                .padding(.vertical, 15.0)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(monthBackgroundColor)
                        .padding(.all, -2.0)
                    HStack(spacing: 0.0) {
                        Text(viewModel.months[12].name)
                            .foregroundStyle(viewModel.currentDate.month == viewModel.months[12].monthIndex && viewModel.currentDate.year == viewModel.selectedDate.year ? .blue : colorScheme == .light ? .black : .white)
                            .font(.title3)
                            .bold()
                            .padding(.all, 5.0)
                        Spacer()
                        
                        var extraDays: Int {
                            if Initializer.shared.leapYears.contains(viewModel.selectedDate.year) {
                                return 7
                            }
                            return 6
                        }
                        
                        ForEach(1..<extraDays, id: \.self) { day in
                            Spacer()
                            ZStack {
                                Circle()
                                    .foregroundStyle(viewModel.currentDate == FRDate(viewModel.selectedDate.year, 13, day) ? .blue : .clear)
                                Text("\(day)")
                                    .font(.system(size: 10))
                            }
                            .frame(maxHeight: 25.0)
                        }
                    }
                }
                .padding(.bottom, 15.0)
                .onTapGesture {
                    viewModel.isMonthView = true
                    viewModel.selectedDate.month = 13
                    viewModel.selectedDate.day = 1
                    viewModel.updatePickerDates()
                }
            }
            .padding(.horizontal, 10.0)
        }
    }
    
    var columns: [GridItem] {
            Array(repeating: GridItem(.flexible(), spacing: 15.0), count: 3)
    }
    var monthBackgroundColor: Color {
        Color.gray(colorScheme == .light ? 0.95 : 0.14)
    }
}

#Preview {
    ContentView()
}

