//
//  ConverterView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-12.
//

import SwiftUI

struct ConverterView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ViewModel
    @State var year: Int = FRDate().year
    @State var month: Int = FRDate().month
    @State var day: Int = FRDate().day
    
    var result: String {
        if selectedCal == .republican {
            return "\(FRDate(year, month, day).toGregorian().formatted(date: .complete, time: .omitted))"
        } else {
            guard let date = Date.from(string: "\(year)-\(month)-\(day)") else { return "" }
            return date.toRepublican().formatted(.complete)
        }
    }
    
    @State var selectedCal: FRDatePicker.CalType = .republican
    
    var body: some View {
        VStack(spacing: 15.0) {
//            Form {
                HStack {
                    Text("Convert to \(selectedCal == .republican ? "Gregorian" : "Republican")")
                        .font(.system(size: 25.0, weight: .bold, design: .default))
                    Spacer()
                }
                .padding(.horizontal, 10.0)
                
                HStack {
                    Text(result)
                    Spacer()
                }
                .padding(.horizontal, 10.0)
                .font(.system(size: 20.0))
                
//                Section {
                    FRDatePicker(type: $selectedCal, year: $year, month: $month, day: $day)
                
                //                FRDatePicker(type: $selectedCal, year: $year, month: $month, day: $day)
                //                    .background(colorScheme == .light ? Color.lightGray : .darkGray)
                //                    .cornerRadius(20.0)
                
                HStack {
                    Button(action: {
                        if selectedCal == .republican {
                            selectedCal = .gregorian
                        } else {
                            selectedCal = .republican
                        }
                    }, label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title2)
                    })
                    .padding(.leading, 10.0)
                    
                    Spacer()
                    
                    Button(action: {
                        if year < 336 {
                            viewModel.selectedDate = FRDate(year, month, day)
                        } else {
                            viewModel.selectedDate = Date.from(string: "\(year)-\(month)-\(day)")!.toRepublican()
                        }
                        viewModel.isMonthView = true
                        viewModel.showConverterView = false
                    }, label: {
                        Image(systemName: "arrowshape.right.circle.fill")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title2)
                    })
                    .padding(.trailing, 10.0)
                }
//                }
//                .padding(.vertical, -15.0)
                Spacer()
//            }
        }
        .padding(.horizontal, 10.0)
        .padding(.top, 25.0)
    }
}

