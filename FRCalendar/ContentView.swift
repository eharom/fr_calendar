//
//  ContentView.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-19.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 0.0) {
            HeaderView(viewModel: viewModel)
            if !viewModel.isMonthView {
                YearCalendarView(viewModel: viewModel)
            } else {
                MonthCalendarView(viewModel: viewModel)
            }
            FooterView(viewModel: viewModel)
        }
    }
}

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack {
            if viewModel.isMonthView {
                Button(action: {
                    viewModel.isMonthView = false
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.blue)
                    Text(viewModel.showRomanNumerals ? "\(viewModel.selectedDate.year)" : "\(Converter.romanNumeralFor(viewModel.selectedDate.year))")
                        .foregroundStyle(.blue)
                        .font(.system(size: 20.0))
                })
            } else {
                Image(systemName: viewModel.showGregorian ? "eye.fill" : "eye.slash.fill")
                    .foregroundStyle(viewModel.showGregorian ? .blue : .gray)
                    .font(.system(size: 20.0))
                    .onTapGesture {
                        viewModel.showGregorian.toggle()
                        viewModel.userDefaults.set(viewModel.showGregorian, forKey: viewModel.showGregorianKey)
                    }
            }
            Spacer()
            Button(action: {
                if viewModel.selectedYearIsCurrentYear() {
                    viewModel.isMonthView = true
                } else {
                    viewModel.selectedDate.year = viewModel.currentDate.year
                }
                viewModel.selectedDate = viewModel.currentDate
                viewModel.updatePickerDates()
            }, label: { Image(systemName: "sun.horizon.fill") })
            .foregroundStyle(.blue)
            .font(.system(size: 25.0))
            
            Button(action: {
                viewModel.showConverterView = true
            }, label: {
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundStyle(.blue)
                    .font(.system(size: 20.0))
            })
                .sheet(isPresented: $viewModel.showConverterView) {
                    ConverterView(viewModel: viewModel)
                        .presentationDetents([.height(400.0)])
                }
                .padding(.leading,25.0)
            Button(action: {
                viewModel.showInfoView = true
            }, label: {
                Image(systemName: "gearshape")
                    .foregroundStyle(.blue)
                    .font(.system(size: 20.0))
            })
                .sheet(isPresented: $viewModel.showInfoView) {
                    InformationView(viewModel: viewModel)
                }
                    .padding(.leading,25.0)
        }
        .padding(.horizontal, 15.0)
        .padding(.bottom, 15.0)
        .padding(.top, UIDevice.smallScreen ? 15.0 : 0.0)
        .background(colorScheme == .light ? Color.lightGray : .darkGray)
        .font(.title2)
    }
}
struct FooterView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack(spacing: 15.0) {
            Button(action: {
                if viewModel.selectedDate.year > 1 {
                    viewModel.selectedDate.year -= 1
                    viewModel.selectedDate.day = 1
                    viewModel.updatePickerDates()
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.blue)
                    .font(.system(size: 25.0))
            })
            Spacer()
            Text(viewModel.showRomanNumerals ? "\(viewModel.selectedDate.year)" : "\(Converter.romanNumeralFor(viewModel.selectedDate.year))")
                .font(.system(size: 28.0, weight: .bold))
                .foregroundStyle(viewModel.selectedDate.year == viewModel.currentDate.year ? .blue : colorScheme == .light ? .black : .white)
                .onTapGesture {
                    viewModel.showRomanNumerals.toggle()
                    viewModel.userDefaults.set(viewModel.showRomanNumerals, forKey: viewModel.showRomanNumeralsKey)
                }
                if viewModel.showGregorian {
                    Text(verbatim: "\(viewModel.selectedDate.year + 1791)/\((viewModel.selectedDate.year + 1792) % 100)")
                        .bold()
                        .font(.system(size: 15.0))
                        .foregroundStyle(.gray)
                }
            Spacer()
            Button(action: {
                if viewModel.selectedDate.year < 334 {
                    viewModel.selectedDate.year += 1
                    viewModel.selectedDate.day = 1
                    viewModel.updatePickerDates()
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.blue)
                    .font(.system(size: 25.0))
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 15.0)
        .padding(.bottom, UIDevice.smallScreen ? 15.0 : 0.0)
        .padding(.horizontal, 25.0)
        .background(colorScheme == .light ? Color.lightGray : .darkGray)
    }
}


#Preview {
    ContentView()
}

