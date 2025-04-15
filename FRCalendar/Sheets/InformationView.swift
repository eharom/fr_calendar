//
//  InformationView.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-11.
//

import SwiftUI

struct InformationView: View {
    @ObservedObject var viewModel: ViewModel
    
    var text = """
    This calendar uses the original rules as outlined by the National Convention and observed between 1792 and 1805.
    
    \"Each year begins at midnight, with the day on which the true autumnal equinox falls for the Paris Observatory.\"
    
    Unlike in the Gregorian system, there is no rule to add leap days every certain years. In the republican calendar a leap day is added only when the following fall equinox is 366 days away. This means leap years are sometimes five years apart, but it guarantees that the dates never fall behind in relation to the season.
    
    """
    @State private var date = FRDate().toGregorian()
    
    let dateRange: ClosedRange<Date> = {
        return FRDate(1, 1, 1).toGregorian()
            ...
        FRDate(334, 13, 6).toGregorian()
    }()

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.white.opacity(0.1))
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0.0) {
                    HStack {
                        Text("About")
                            .font(.system(size: 35.0, weight: .bold))
                            .foregroundStyle(.white.opacity(0.4))
                        Spacer()
                    }
                    .padding(.bottom, 15.0)
                    Text(text)
                        .font(.system(size: 22.0))
                    Text("[Read more about it](https://en.wikipedia.org/wiki/French_Republican_calendar#After_the_Republic)")
                }
                .padding(.bottom, 30.0)
            }
            .foregroundStyle(.white.opacity(0.9))
            .padding(.horizontal, 20.0)
            .padding(.top, 30.0)
        }
        .background(.black)
    }
}




#Preview {
    ContentView()
}

