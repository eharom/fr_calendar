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
//        print("Widget date entry", entry.date, frDate)
//        print(Calendar.current)
    }

    var body: some View {
        VStack(spacing: 0.0) {
            Text("\(frDate.monthName.prefix(4))")
                .font(.system(size: 20.0/*35.0*/, weight: .semibold, design: .default))
                .foregroundStyle(.red)
            Text("\(frDate.day)")
                .font(.system(size: 90.0
                              , weight: .semibold, design: .rounded))
                .padding(.vertical, -13.0)
            Text("\(Initializer.shared.celebrations[frDate.dayOfYear - 1])")
                .font(.system(size: 18.0, weight: .bold, design: .default))
                .foregroundStyle(.gray)
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
        .description("Displays current republican date along with date's celebration.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    FRCalendarWidget()
} timeline: {
    DateEntry(date: Date())
    //    DateEntry(date: FRDate(233, 8, 4).toGregorian())
}








//import WidgetKit
//import SwiftUI
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), emoji: "😀")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), emoji: "😀")
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, emoji: "😀")
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
/////mgkdmskdg
////    func relevances() async -> WidgetRelevances<Void> {
////        // Generate a list containing the contexts this widget is relevant in.
////    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let emoji: String
//}
//
//
//struct FRCalendarWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Emoji:")
//            Text(entry.emoji)
//        }
//    }
//}
//
//struct FRCalendarWidget: Widget {
//    let kind: String = "FRCalendarWidget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            if #available(iOS 17.0, *) {
//                FRCalendarWidgetEntryView(entry: entry)
//                    .containerBackground(.fill.tertiary, for: .widget)
//            } else {
//                FRCalendarWidgetEntryView(entry: entry)
//                    .padding()
//                    .background()
//            }
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//#Preview(as: .systemSmall) {
//    FRCalendarWidget()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
