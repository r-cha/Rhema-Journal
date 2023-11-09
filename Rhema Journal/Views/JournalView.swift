/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A grid that displays all Entrys.
*/

import SwiftUI

import BibleKit


struct JournalView: View {
    var entries: [Entry]
    let selectEntry: (Entry) -> Void
    let addEntry: () -> Void
    
    @State private var parsedVerses: [String] = []

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(Design.galleryGridSize)],
                spacing: 10
            ) {
                // Check if most recent entry is from today
                if entries.isEmpty || !Calendar.current.isDateInToday(entries.first?.timestamp ?? Date.distantPast) {
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
                            if let parsedVerses = Optional(RefParser.parseReferences(entry.references)) {
                                if parsedVerses.count > 0 {
                                    HStack {
                                        ForEach(parsedVerses.indices, id: \.self) {index in
                                            ReferencePill(reference: parsedVerses[index].toString())
                                        }
                                    }
                                }
                            }
                        }.onAppear {
                            self.parsedVerses = RefParser.parseReferences(entry.references).map({$0.toString()})
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
