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
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 10
            ) {
                // Check if most recent entry is from today
                if entries.isEmpty || !Calendar.current.isDateInToday(entries.first?.timestamp ?? Date.distantPast) {
                    // Button to add an entry for today
                    JournalItemView(backgroundStyle: Color.rhemaDark, action: addEntry) {
                        HStack {
                            Image(systemName: "plus")
                                .shadow(color: colorScheme == .light ? .black : .white, radius: 2)
                            Text("Today")
                        }
                    }
                    Divider()
                }

                // List all past entries
                ForEach(entries) { entry in
                    JournalItemView(backgroundStyle: Color.rhemaDark) {
                        selectEntry(entry)
                    } label: {
                        VStack(alignment: .leading) {
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
                    Divider()
                }
            }
        }
        //.scrollClipDisabled()
        .navigationDestination(for: Entry.self) { selectedEntry in
            EntryView(entry: selectedEntry)
        }
    }
}
