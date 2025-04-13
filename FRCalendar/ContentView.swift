//
//  ContentView.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-19.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel = ViewModel()
	
	var body: some View {
		VStack(spacing: 0.0) {
			HeaderView(viewModel: viewModel)
			if !viewModel.isMonthView {
				YearCalendarView(viewModel: viewModel)
					.gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
						.onEnded({ value in
							if value.translation.height < 0.0 {
								viewModel.selectedDate.year += 1
							}
							
							if value.translation.height > 0.0 {
								viewModel.selectedDate.year -= 1
							}
						}))
			} else {
				MonthCalendarView(viewModel: viewModel)
			}
			FooterView(viewModel: viewModel)
		}
		.background(.black)
	}
}

struct HeaderView: View {
	@ObservedObject var viewModel: ViewModel
	var body: some View {
		HStack {
			if viewModel.isMonthView {
				Button(action: {
					viewModel.isMonthView = false
				}, label: {
					Image(systemName: "chevron.left")
					Text(viewModel.yearWasTapped ? "\(viewModel.selectedDate.year)" : "\(Converter.romanNumeralFor(viewModel.selectedDate.year))")
						.font(.title3)
				})
			} else {
				
			}
			Spacer()

			Button(action: {
				viewModel.showConverterView = true
			}, label: {
				Image(systemName: "arrow.left.arrow.right")
					.foregroundStyle(.white.opacity(0.9))
					.font(.title3)
			})
				.sheet(isPresented: $viewModel.showConverterView) {
					ConverterView()
						.presentationDetents([.height(400.0)])
				}
			
			Button(action: {
				viewModel.showInfoView = true
			}, label: {
				Image(systemName: "info.circle")
					.foregroundStyle(.white.opacity(0.9))
					.font(.title3)
			})
				.sheet(isPresented: $viewModel.showInfoView) {
					InformationView()
				}

			.padding(.leading, 40.0)
		}
		.padding(.horizontal, 15.0)
		.padding(.bottom, 15.0)
		.background(.white.opacity(0.1))
		.foregroundStyle(.red)
		.font(.title2)
	}
}
struct FooterView: View {
	@ObservedObject var viewModel: ViewModel
	var body: some View {
		GrayDivider()
		HStack {
			Spacer()
			Button(action: {
				viewModel.isMonthView = true
				viewModel.selectedDate = viewModel.currentDate
			}, label: { Text("Today") })
			Spacer()
		}
		.padding(.horizontal, 15.0)
		.padding(.top, 15.0)
		.background(Color(white: 0.1))
		.foregroundStyle(.red)
		.font(.title3)

	}
}


#Preview {
	ContentView()
}
