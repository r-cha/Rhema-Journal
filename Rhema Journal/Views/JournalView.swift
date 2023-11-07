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
                spacing: 20
            ) {
                if Design.editFeatureEnabled {
                    JournalItemView(backgroundStyle: .fill.tertiary, action: addEntry) {
                        LabeledContent("Add Entry") {
                            Image(systemName: "plus")
                        }
                        .labelsHidden()
                    }
                    .shadow(radius: 2)
                }

                ForEach(entries) { entry in
                    JournalItemView(backgroundStyle: Color.cardFront) {
                        selectEntry(entry)
                    } label: {
                        Text(entry.title())
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
