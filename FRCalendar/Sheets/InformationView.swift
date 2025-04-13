//
//  InformationView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-11.
//

import SwiftUI

struct InformationView: View {
	@ObservedObject var viewModel = ViewModel()
	
	var information = """
		The French Republican Calendar was a secular calendar proposed during the
		French Revolution. It aimed to replace the Gregorian calendar as an easier
		and more rational way to measure time, starting always on the fall equinox.
		\n
		While it was only used officially for a little over a decade, it is still usable!
		"""
	@State private var date = FRDate().toGregorian()
	
	let dateRange: ClosedRange<Date> = {
		return FRDate(1, 1, 1).toGregorian()
			...
		FRDate(334, 13, 6).toGregorian()
	}()

	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 0.0) {
				HStack {
					Text("About")
						.font(.system(size: 35.0, weight: .bold))
						.foregroundStyle(.white.opacity(0.4))
					Spacer()
				}
				.padding(.bottom, 15.0)
				Text(information)
				 .font(.system(size: 22.0))
			}
			.padding(.bottom, 30.0)

//			DatePicker(selection: $date, in: dateRange, displayedComponents: [.date, .hourAndMinute]) {
//				Text("Gregorian:")
//			}
//				.datePickerStyle(WheelDatePickerStyle())
//				.font(.system(size: 22.0))
		}
		.foregroundStyle(.white.opacity(0.9))
		.background(Color.white.opacity(0.0))
		.padding(.horizontal, 20.0)
		.padding(.top, 30.0)


	}
}




#Preview {
	ContentView()
}
