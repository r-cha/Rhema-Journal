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
    let deleteEntry: (IndexSet) -> Void
    
    @State private var parsedVerses: [String] = []
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var needsToday: Bool = false

    var body: some View {
        List {
            // Check if most recent entry is from today
            if needsToday {
                // Button to add an entry for today
                JournalItemView(
                    backgroundStyle: Color.rhemaDark,
                    action: addEntry
                ) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Today")
                    }
                }
                .shadow(color: colorScheme == .light ? .rhemaDark : .rhema, radius: 2)
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .listRowSeparator(.hidden)
            }

            // List all past entries
            ForEach(entries) { entry in
                Group {
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
                }
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
            .onDelete(perform: deleteEntry)
        }
        .listStyle(.plain)
        .navigationDestination(for: Entry.self) { selectedEntry in
            EntryView(entry: selectedEntry)
        }
        .onAppear {
            // Update the condition whenever the view appears
            needsToday = entries.isEmpty || !Calendar.current.isDateInToday(entries.first?.timestamp ?? Date.distantPast)
        }
    }
}
