/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A reusable view for content presented as a card visually.
*/

import SwiftUI

import BibleKit


struct EntryView: View {
    @Bindable var entry: Entry
    
    init(entry: Entry) {
        self.entry = entry
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    private func deletePromptResponse(at offsets: IndexSet) {
        entry.promptResponses.remove(atOffsets: offsets)
    }

    var body: some View {
        VStack {
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

                    BibleVersePicker(references: $entry.references)

                } header: {
                    Text("Settings")
                }

                Section {
                    ForEach(entry.promptResponses.sorted {
                        Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
                    }, id: \.self) { response in
                        ResponseView(promptResponse: response).padding([.top], 5)
                    }
                    .onDelete(perform: deletePromptResponse)
                    // TODO: onMove to reorder responses
                    // TODO: add prompts
                    // TODO: Just get the order right to begin with
                } header: {
                    Text("Responses")
                }
            }
            .navigationBarTitle(entry.title())
        }
    }
}
