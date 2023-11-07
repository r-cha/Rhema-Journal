/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A reusable view for content presented as a card visually.
*/

import SwiftUI


struct EntryView: View {
    @Bindable var entry: Entry

    var body: some View {
        NavigationView {
            Form {
                Picker("Type", selection: $entry.style) {
                    ForEach(Style.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .onChange(of: entry.style) { old, newValue in
                    entry.promptResponses = Prompts[newValue] ?? []
                }

                ForEach(entry.promptResponses.indices, id: \.self) { index in
                    ResponseView(promptResponse: entry.promptResponses[index])
                }
            }
            .navigationBarTitle(entry.title())
        }
    }
}
