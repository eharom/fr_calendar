//
//  NewYear.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-03.
//

import SwiftUI

struct YearCalendarView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
            VStack(spacing: 0.0) {
                
                //            Year header
                HStack {
                    Text(viewModel.showRomanNumerals ? "\(viewModel.selectedDate.year)" : "\(Converter.romanNumeralFor(viewModel.selectedDate.year))")
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(viewModel.selectedDate.year == viewModel.currentDate.year ? .red : Color(white: 0.9))
                        .onTapGesture {
                            viewModel.showRomanNumerals.toggle()
                            viewModel.userDefaults.set(viewModel.showRomanNumerals, forKey: viewModel.showRomanNumeralsKey)
                        }
                    Spacer()
                    if viewModel.showGregorian {
                        Text(verbatim: "\(viewModel.selectedDate.year + 1791) - \(viewModel.selectedDate.year + 1792)")
                            .bold()
                            .font(.title3)
                            .foregroundStyle(Color(white: 0.5))
                    }
                }
                .padding(.vertical, 5.0)
                
                GrayDivider().padding(.bottom, 10.0)
                
                //            Mini month cards for months 1 - 12
                LazyVGrid(columns: columns, spacing: 15.0) {
                    ForEach(1..<13) { i in
                        MiniMonthView(viewModel: viewModel, monthIndex: i)
                            .onTapGesture {
                                viewModel.isMonthView = true
                                viewModel.selectedDate.month = i
                                viewModel.selectedDate.day = 1
                            }
                    }
                }
                
                Spacer()
                
                //            Mini month card
                ZStack {
                    Rectangle()
                        .foregroundStyle(.black)
                    HStack(spacing: 0.0) {
                        Text(viewModel.months[12].name)
                            .foregroundStyle(viewModel.currentDate.month == viewModel.months[12].monthIndex && viewModel.currentDate.year == viewModel.selectedDate.year ? .red : Color(white: 0.9))
                            .font(.title3)
                            .bold()
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
                                    .foregroundStyle(viewModel.currentDate == FRDate(viewModel.selectedDate.year, 13, day) ? .red : .clear)
                                Text("\(day)")
                                    .foregroundStyle(Color(white: 0.9))
                                    .font(.system(size: 10))
                            }
                            .frame(maxHeight: 25.0)
                        }
                    }
                }
                .onTapGesture {
                    viewModel.isMonthView = true
                    viewModel.selectedDate.month = 13
                    viewModel.selectedDate.day = 1
                }
                
                Spacer()
            }
            .padding(.horizontal, 10.0)
        }
    }
    
    var columns: [GridItem] {
            Array(repeating: GridItem(.flexible(), spacing: 15.0), count: 3)
    }
}


struct AText: View {
    var text: String
    var alignment: Alignment
    
    init(_ text: String, alignment: Alignment) {
        self.text = text
        self.alignment = alignment
    }
    
    var body: some View {
        HStack(spacing: 0.0) {
            if alignment == .trailing {
                Spacer()
            }
            Text(text)
            if alignment == .leading {
                Spacer()
            }
        }
    }
    
    enum Alignment {
        case leading, trailing
    }
}

#Preview {
    ContentView()
}

