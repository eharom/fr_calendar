//
//  CalendarView.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-22.
//

import SwiftUI

struct CalendarView: View {
	@ObservedObject var viewModel = CalendarViewModel()
//	var activeMontIndex: Int

	
	var body: some View {
		VStack(spacing: 0.0) {
			CalendarHeaderView(isMonthView: $viewModel.isMonthView)
			ScrollView() {
				yearView
//				extraDaysCards
			}
			.frame(maxHeight: viewModel.isMonthView ? 178.0 : .infinity)
			
			GrayDivider()
			
			if viewModel.isMonthView {
				ZStack {
					ScrollView {
						VStack {
							Spacer()
							Text(Date().description)
							Spacer()
							Text("\(Date(timeIntervalSinceNow: -100000.0))")
							Spacer()
							Text("\(viewModel.oneYearLater)")
								
						}
						.bold()
						.font(.title2)
						.foregroundStyle(.gray)
					}
				}
				Spacer()
			}
			CalendarFooterView()
		}
		.background(.black)
	}
	
	var yearView: some View {
		VStack(spacing: 0.0) {
			if !viewModel.isMonthView {
				VStack(spacing: 0.0) {
					HStack {
						Text("CCXXXIII")
							.bold()
							.font(.largeTitle)
							.foregroundStyle(.red)
						Spacer()
					}
					.padding(.leading, 10.0)
					.padding(.vertical, 5.0)
					GrayDivider()
						.padding(.bottom, 10.0)
				}
			}
			LazyVGrid(columns: getColumns(viewModel.isMonthView), spacing: 0.0) {
				ForEach(viewModel.months) { month in
					MonthView(month: month, isMonthView: $viewModel.isMonthView)
				}
			}
			.padding(.horizontal, viewModel.isMonthView ? 0.0 : 10.0)
		}
	}
	
	func getColumns(_ isMonthView: Bool) -> [GridItem] {
		return Array(repeating: GridItem(.flexible(), spacing: 15.0), count: isMonthView ? 1 : 3)
	}
}

struct CalendarHeaderView: View {
	@Binding var isMonthView: Bool
	var daysOfTheWeek = ["P", "D", "T", "C", "Q", "S", "S", "O", "N", "D"]
	var body: some View {
		VStack(spacing: 0.0) {
			toolbar().padding(.bottom, 10.0)
			monthNameBar(isMonthView)
			
			if isMonthView {
				GrayDivider()
					.padding(.top, 2.0)
			}
		}
		.foregroundColor(.white)
		.background(Color(white: 0.1))
	}
	
	@ViewBuilder
	func monthNameBar(_ isMonthView: Bool) -> some View {
		if isMonthView {
			
			VStack(spacing: 10.0) {
				HStack {
					Text("Month")
						.font(.largeTitle)
						.bold()
					Spacer()
				}
				.padding(.horizontal, 15.0)
				
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 39.0), spacing: 0.0)], spacing: 0.0) {
					ForEach(0..<daysOfTheWeek.count, id: \.self) { i in
						Text(daysOfTheWeek[i])
							.font(.footnote)
					}
				}
			}
			
		} else {
			EmptyView()
		}
	}
	
	func toolbar() -> some View {
		return HStack {
			if isMonthView {
				Button(action: {
					isMonthView = false
				}, label: {
					Image(systemName: "chevron.left")
					Text("CCXXXIII")
						.font(.title3)
				})
			}
			Spacer()
			
			Button(action: {
				print("Search")
			}, label: {
				Image(systemName: "magnifyingglass")
			})

			Button(action: {
				print("+")
			}, label: {
				Image(systemName: "plus")
			})
		}
		.foregroundStyle(.red)
		.padding(.leading, 5.0)
		.padding(.trailing, 10.0)
		.font(.title2)
	}
}

struct CalendarFooterView: View {
	var body: some View {
		HStack {
			Button(action: {
				print("Hoy")
			}, label: {
				Text("Hoy")
			})
			Spacer()
			Button(action: {
				print("Entrada")
			}, label: {
				Text("Entrada")
			})
		}
		.padding(.all, 15.0)
		.background(Color(white: 0.1))
		.font(.title3)
		.foregroundStyle(.red)
	}
}

struct GrayDivider: View {
	var body: some View {
		Rectangle()
			.frame(maxWidth: .infinity)
			.frame(height: 1.0)
			.foregroundStyle(Color(white: 0.2))
	}
}

#Preview {
	CalendarView()
}

