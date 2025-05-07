//
//  MiniMonthView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-04.
//

import SwiftUI

struct MiniMonthView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ViewModel
    var monthIndex: Int
//    var currentDay: Int?
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(alignment: .top) {
                Text(viewModel.months[monthIndex - 1].name.prefix(4))
                    .foregroundStyle((viewModel.selectedDate.year == viewModel.currentDate.year && viewModel.currentDate.month == monthIndex) ? .blue : colorScheme == .light ? .black : .white)
                    .font(.title3)
                    .bold()
                    .padding(.bottom, UIDevice.smallScreen ? 0.0 : 5.0)
                Spacer()
                Image(systemName: viewModel.months[monthIndex - 1].seasonLogo)
                    .font(.system(size: 18.0))
            }
            ForEach(0..<6) { row in
                HStack {
                    ForEach(1..<6) { col in
                        let index = row * 5 + col
                        ZStack {
                            Circle()
                                .foregroundStyle(viewModel.currentDate == FRDate(viewModel.selectedDate.year, monthIndex, index) ? .blue : .clear)
                            Text("\(index)")
                                .foregroundStyle(colorScheme == .light ? .black : .white)
                                .font(.system(size: 10))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
