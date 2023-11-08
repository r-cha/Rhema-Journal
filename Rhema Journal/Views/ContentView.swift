/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main view that contains the majority of the app's content.
*/

import SwiftUI
import SwiftData

import BibleKit

struct ContentView: View {
    @Query(
        sort: [SortDescriptor(\Entry.timestamp, order: .reverse)]
    ) private var entries: [Entry]
    @State private var navigationPath: [Entry] = []
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack(path: $navigationPath) {
            JournalView(entries: entries) { entry in
                withAnimation { navigationPath.append(entry) }
            } addEntry: {
                // TODO: Start w yesterday's chapter + 1
                let newEntry = Entry(style: Style.lectio, bibleReference: Reference(book:"Genesis", startChapter:1, startVerse:1), promptResponses: init_prompts(style: Style.lectio))
                modelContext.insert(newEntry)
                withAnimation { navigationPath.append(newEntry) }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
