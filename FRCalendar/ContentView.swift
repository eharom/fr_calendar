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
                    .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
                        .onEnded({ value in
                            if value.translation.height < 0.0 {
                                if viewModel.selectedDate.year < 334 {
                                    viewModel.selectedDate.year += 1
                                }
                            }
                            if value.translation.height > 0.0 {
                                if viewModel.selectedDate.year > 1 {
                                    viewModel.selectedDate.year -= 1
                                }
                            }
                        }))
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
                        .foregroundStyle(.red)
                    Text(viewModel.showRomanNumerals ? "\(viewModel.selectedDate.year)" : "\(Converter.romanNumeralFor(viewModel.selectedDate.year))")
                        .foregroundStyle(.red)
                        .font(.title3)
                })
            } else {
                Image(systemName: viewModel.showGregorian ? "eye.fill" : "eye.slash.fill")
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        viewModel.showGregorian.toggle()
                        viewModel.userDefaults.set(viewModel.showGregorian, forKey: viewModel.showGregorianKey)
                    }
            }
            Spacer()
            
            Button(action: {
                viewModel.showConverterView = true
            }, label: {
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundStyle(.red)
                    .font(.title3)
            })
                .sheet(isPresented: $viewModel.showConverterView) {
                    ConverterView(viewModel: viewModel)
                        .presentationDetents([.height(400.0)])
                }
            
            Button(action: {
                viewModel.showInfoView = true
            }, label: {
                Image(systemName: "info.circle")
                    .foregroundStyle(.red)
                    .font(.title3)
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
//        GrayDivider()
        HStack {
            Button(action: {
                if viewModel.selectedYearIsCurrentYear() {
                    viewModel.isMonthView = true
                } else {
                    viewModel.selectedDate.year = viewModel.currentDate.year
                }
                viewModel.selectedDate = viewModel.currentDate
            }, label: { Text("Today") })
            .foregroundStyle(.red)
            Spacer()
            Button(action: {
                viewModel.showReminderCreationView = true
            }, label: { Image(systemName: "plus").foregroundStyle(.red) })
            .sheet(isPresented: $viewModel.showReminderCreationView) {
                ReminderCreationView(viewModel: viewModel)
            }
        }
        .padding(.horizontal, 15.0)
        .padding(.top, 15.0)
        .padding(.bottom, UIDevice.smallScreen ? 15.0 : 0.0)
        .background(colorScheme == .light ? Color.lightGray : .darkGray)
        .font(.title3)

    }
}


#Preview {
    ContentView()
}

