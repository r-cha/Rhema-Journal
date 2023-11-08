/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A reusable view for content presented as a card visually.
*/

import SwiftUI

import BibleKit


struct EntryView: View {
    @Bindable var entry: Entry

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type", selection: $entry.style) {
                        ForEach(Style.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .onChange(of: entry.style) { old, newValue in
                        entry.promptResponses = init_prompts(style: newValue)
                    }

                    BibleVersePicker(ref: $entry.bibleReference)

                } header: {
                    Text("Settings")
                }

                Section {
                    ForEach(entry.promptResponses.indices, id: \.self) { index in
                        ResponseView(promptResponse: entry.promptResponses[index])
                    }
                } header: {
                    Text("Responses")
                }
            }
            .navigationBarTitle(entry.title())
        }
    }
}
