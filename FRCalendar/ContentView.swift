//
//  ContentView.swift
//  Calendar
//
//  Created by Enrique Haro Márquez on 2025-03-19.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel = ViewModel()
	var h = UIScreen.main.bounds.height / 2.5
	
	var body: some View {
		@State var yPos = h + (h * 1.8)

		VStack(spacing: 0.0) {
			HeaderView(viewModel: viewModel)
			
			if !viewModel.isMonthView {
//				ZStack {
					YearCalendarView(viewModel: viewModel)
//						YearCalendarView(viewModel: viewModel)
//							.border(.red)
//							.position(x: UIScreen.main.bounds.width / 2.0, y: yPos)
//					}
					.gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
											.onEnded({ value in
												if value.translation.height < 0.0 {
													viewModel.selectedDate.year += 1
												}

												if value.translation.height > 0.0 {
													viewModel.selectedDate.year -= 1
												}
											}))
//
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
					viewModel.isMonthView.toggle()
				}, label: {
					Image(systemName: "chevron.left")
					Text("\(viewModel.selectedDate.year)")
						.font(.title3)
				})
			}
			Spacer()
			Button(action: { }, label: { Image(systemName: "plus") })
				.foregroundStyle(Color(white: 0.1))
		}
		.padding(.horizontal, 15.0)
		.padding(.bottom, 15.0)
		.background(Color(white: 0.1))
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
