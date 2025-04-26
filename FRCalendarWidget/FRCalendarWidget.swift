//
//  FRCalendarWidget.swift
//  FRCalendarWidget
//
//  Created by Enrique Haro Márquez on 2025-04-22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DateEntry {
        DateEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DateEntry) -> ()) {
        let entry = DateEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DateEntry] = []
        
        let currentDate = Date()
        for dayOffset in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DateEntry(date: startOfDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DateEntry: TimelineEntry {
    let date: Date
}

struct FRCalendarWidgetEntryView : View {
    var entry: Provider.Entry
    var frDate: FRDate
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.frDate = entry.date.toRepublican()
    }

    var body: some View {
        VStack(spacing: 0.0) {
            Text("\(frDate.monthName)")
                .font(.system(size: 25.0, weight: .semibold, design: .default))
                .foregroundStyle(.red)
            Text("\(frDate.day)")
                .font(.system(size: 90.0
                              , weight: .semibold, design: .rounded))
                .padding(.vertical, -13.0)
            Text("\(frDate.celebration)")
                .font(.system(size: 18.0, weight: .bold, design: .default))
                .foregroundStyle(.gray)
        }
    }
}
struct MonthGridWidgetEntryView : View {
    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry
    var frDate: FRDate
    var daysInLastMonth: Int { frDate.isLeapYear ? 6 : 5 }
    var isLastMonth: Bool { frDate.month == 13 }
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.frDate = entry.date.toRepublican()
    }
    var body: some View {
        VStack(spacing: 8.0) {
            HStack {
                Text(frDate.monthName.uppercased())
                    .font(.system(size: 14.0, weight: .semibold))
                    .foregroundStyle(.red)
                Spacer()
                Text("\(frDate.celebration)".uppercased())
                    .font(.system(size: 13.0, weight: .semibold))
            }
            .padding(.bottom, 5.0)
            
            ForEach(0..<(!isLastMonth ? 3 : 1), id: \.self) { row in
                if isLastMonth{ Spacer() }
                HStack(spacing: 10.0) {
                    ForEach(1..<(!isLastMonth ? 11 : daysInLastMonth + 1), id: \.self) { col in
                        let index = row * 10 + col
                        let isCurrentDate = frDate == FRDate(frDate.year, frDate.month, index)
                        ZStack {
                            Circle()
                                .foregroundStyle(isCurrentDate ? .red : .clear)
                            Text("\(index)")
                                .foregroundStyle(isCurrentDate ? .white : index % 5 == 0 ? .gray : colorScheme == .light ? .black : .white)
                                .font(.system(size: 12.0, weight: .semibold))
                        }
                    }
                }
                if isLastMonth{ Spacer() }
            }
        }
    }
}
struct InlineDateWidgetEntryView : View {
    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry
    var frDate: FRDate
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.frDate = entry.date.toRepublican()
    }

    var body: some View {
        if frDate.month == 13 {
            Text("|  \(frDate.sansculottides)")
        } else {
            Text("|  \(frDate.monthName) \(frDate.day)")
        }
    }
}
struct AccesoryDateWidgetEntryView : View {
    var entry: Provider.Entry
    var frDate: FRDate
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.frDate = entry.date.toRepublican()
    }

    var body: some View {
        if frDate.month == 13 {
            Text("Day of \(frDate.celebration), \(frDate.year)")
                .font(.system(size: 20.0, weight: .semibold))
        } else {
            Text("\(frDate.monthName) \(frDate.day), \(frDate.year)")
                .font(.system(size: 20.0, weight: .semibold))
        }
    }
}

struct FRCalendarWidget: Widget {
    let kind: String = "FRCalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FRCalendarWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                FRCalendarWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Republican Date")
        .description("Displays republican date along with date's celebration.")
        .supportedFamilies([.systemSmall])
    }
}
struct MonthGridWidget: Widget {
    let kind: String = "MonthGridWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MonthGridWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MonthGridWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Republican Month")
        .description("Displays republican month and shows current day.")
        .supportedFamilies([.systemMedium])
    }
}
struct InlineDateWidget: Widget {
    let kind: String = "InlineDateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                InlineDateWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                InlineDateWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Republican Date")
        .description("Displays republican date.")
        .supportedFamilies([.accessoryInline])
    }
}
struct AccesoryDateWidget: Widget {
    let kind: String = "AccesoryDateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                AccesoryDateWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                AccesoryDateWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Republican Date")
        .description("Displays republican date.")
        .supportedFamilies([.accessoryRectangular])
    }
}

#Preview(as: .systemMedium) {
//    InlineDateWidget()
//    AccesoryDateWidget()
//    FRCalendarWidget()
    MonthGridWidget()
} timeline: {
    DateEntry(date: FRDate(233, 13, 1).toGregorian())
    //    DateEntry(date: FRDate(233, 8, 4).toGregorian())
}
