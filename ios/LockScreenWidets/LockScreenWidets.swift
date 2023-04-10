//
//  LockScreenWidets.swift
//  LockScreenWidets
//
//  Created by nax0100 on 2023/04/10.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LockScreenWidetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("DiQt").frame(maxWidth: .infinity, maxHeight: .infinity).background(.black)
    }
}

struct LockScreenWidets: Widget {
    let kind: String = "LockScreenWidets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LockScreenWidetsEntryView(entry: entry)
        }
        .configurationDisplayName("アプリボタン")
        .description( "アプリを素早く起動できます。")
        .supportedFamilies([
            .accessoryCircular
        ])
    }
}

struct LockScreenWidets_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenWidetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
