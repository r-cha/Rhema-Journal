/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A grid that displays all Entrys.
*/

import SwiftUI


struct JournalView: View {
    var entries: [Entry]
    let selectEntry: (Entry) -> Void
    let addEntry: () -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(Design.galleryGridSize)],
                spacing: 10
            ) {
                // Check if most recent entry is from today
                if let mostRecentEntry = entries.first, !Calendar.current.isDateInToday(mostRecentEntry.timestamp) {
                    // Button to add an entry for today
                    JournalItemView(backgroundStyle: .fill.tertiary, action: addEntry) {
                        LabeledContent("Add Entry") {
                            Image(systemName: "plus")
                        }
                        .labelsHidden()
                    }
                    .shadow(radius: 2)
                }

                // List all past entries
                ForEach(entries) { entry in
                    JournalItemView(backgroundStyle: Color.cardFront) {
                        selectEntry(entry)
                    } label: {
                        VStack {
                            Text(entry.title())
                            Text(entry.bibleReference.toString()).font(.subheadline)
                        }
                    }
                }
            }
        }
        .scrollClipDisabled()
        .navigationDestination(for: Entry.self) { selectedEntry in
            EntryView(entry: selectedEntry)
        }
    }
}
