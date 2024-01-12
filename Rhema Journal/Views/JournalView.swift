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
    
    var body: some View {
        ScrollView(.vertical) {
            HStack {Spacer()}
            CardView(action: addEntry) {
                HStack {
                    Image(systemName: "plus")
                    Text("New Entry")
                    Spacer()
                }
                .foregroundStyle(Color.accentColor)
            }
            Divider().foregroundStyle(Color.black)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {Spacer()}
                ForEach(entries) {entry in
                    CardView() {
                        selectEntry(entry)
                    } label: {
                        JournalLabelContent(entry: entry)
                    }
                    .background(.clear)
                }
                .navigationDestination(for: Entry.self) { selectedEntry in
                    EntryView(entry: selectedEntry)
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .leading
        )
        .padding(.horizontal)
    }
}
