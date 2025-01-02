//
//  Dex3WidgetLiveActivity.swift
//  Dex3Widget
//
//  Created by Muharrem Efe Çayırbahçe on 1.01.2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Dex3WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Dex3WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Dex3WidgetAttributes.self) { context in
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

extension Dex3WidgetAttributes {
    fileprivate static var preview: Dex3WidgetAttributes {
        Dex3WidgetAttributes(name: "World")
    }
}

extension Dex3WidgetAttributes.ContentState {
    fileprivate static var smiley: Dex3WidgetAttributes.ContentState {
        Dex3WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Dex3WidgetAttributes.ContentState {
         Dex3WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Dex3WidgetAttributes.preview) {
   Dex3WidgetLiveActivity()
} contentStates: {
    Dex3WidgetAttributes.ContentState.smiley
    Dex3WidgetAttributes.ContentState.starEyes
}
