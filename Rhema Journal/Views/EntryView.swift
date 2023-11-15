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

    var body: some View {
        VStack {
            Form {
                Section {
                    BibleVersePicker(references: $entry.references)
                }

                Section {
                    ForEach(entry.promptResponses.sorted {
                        Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
                    }, id: \.self) { response in
                        ResponseView(promptResponse: response).padding([.top], 5)
                    }
                } header: {
                    Text("Responses")
                }
            }
            .navigationTitle(entry.title())
            //.toolbar {
            //    ToolbarItem(placement: .topBarLeading) {
            //        Text(entry.title())
            //    }
            //    ToolbarItem(placement: .topBarTrailing){
            //        NavigationLink(destination: SettingsView()) {
            //            Image(systemName: "heart")
            //        }
            //    }
            //}
        }
    }
}
