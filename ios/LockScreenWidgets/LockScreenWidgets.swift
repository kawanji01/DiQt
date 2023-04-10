//
//  LockScreenWidgets.swift
//  LockScreenWidgets
//
//  Created by 相川真司 on 2023/04/10.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct LockScreenWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        return ZStack {
            Color(white: 1, opacity: 0.3)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Image("lockwidget").resizable().frame(width: 50, height:50)
        }
    }
}

struct LockScreenWidgets: Widget {
    let kind: String = "LockScreenWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            LockScreenWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("アプリボタン")
        .description( "アプリを素早く起動できます。")
        .supportedFamilies([
            .accessoryCircular
        ])
    }
}

struct LockScreenWidgets_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenWidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
