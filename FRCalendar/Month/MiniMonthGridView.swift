//
//  MiniMonthView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-04.
//

import SwiftUI

struct MiniMonthView: View {
    @ObservedObject var viewModel: ViewModel
    var monthIndex: Int
//    var currentDay: Int?
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(viewModel.months[monthIndex - 1].shortName)
                    .foregroundStyle((viewModel.selectedDate.year == viewModel.currentDate.year && viewModel.currentDate.month == monthIndex) ? .red : Color(white: 0.9))
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 5.0)
                Spacer()
            }
            ForEach(0..<6) { row in
                HStack {
                    ForEach(1..<6) { col in
                        let index = row * 5 + col
                        ZStack {
                            Circle()
                                .foregroundStyle(viewModel.currentDate == FRDate(viewModel.selectedDate.year, monthIndex, index) ? .red : .clear)
                            Text("\(index)")
                                .foregroundStyle(Color(white: 0.9))
                                .font(.system(size: 10))
                        }
                    }
                }
            }
        }
    }
}

