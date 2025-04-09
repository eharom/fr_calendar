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
//					.gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
//											.onEnded({ value in
//												if value.translation.height < 0.0 {
//													viewModel.selectedDate.year += 1
//													withAnimation(.linear(duration: 1.0)) {
//														yPos = h
//													}
//												}
//
//												if value.translation.height > 0.0 {
//													viewModel.selectedDate.year -= 1
//												}
//											}))
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
					Text(Converter.romanNumeralFor(viewModel.selectedDate.year))
						.font(.title3)
				})
			}
			Spacer()
			Button(action: { }, label: { Image(systemName: "magnifyingglass") })
				.padding(.trailing, 25.0)
			Button(action: { }, label: { Image(systemName: "plus") })
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
			Button(action: {
				viewModel.isMonthView = true
				viewModel.selectedDate = viewModel.currentDate
			}, label: { Text("Today") })
			Spacer()
			Button(action: { }, label: { Text("Entry") })
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
