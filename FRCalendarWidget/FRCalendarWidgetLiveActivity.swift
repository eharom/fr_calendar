//
//  FRCalendarWidgetLiveActivity.swift
//  FRCalendarWidget
//
//  Created by Enrique Haro Márquez on 2025-04-22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FRCalendarWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct FRCalendarWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FRCalendarWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension FRCalendarWidgetAttributes {
    fileprivate static var preview: FRCalendarWidgetAttributes {
        FRCalendarWidgetAttributes(name: "World")
    }
}

extension FRCalendarWidgetAttributes.ContentState {
    fileprivate static var smiley: FRCalendarWidgetAttributes.ContentState {
        FRCalendarWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: FRCalendarWidgetAttributes.ContentState {
         FRCalendarWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: FRCalendarWidgetAttributes.preview) {
   FRCalendarWidgetLiveActivity()
} contentStates: {
    FRCalendarWidgetAttributes.ContentState.smiley
    FRCalendarWidgetAttributes.ContentState.starEyes
}
