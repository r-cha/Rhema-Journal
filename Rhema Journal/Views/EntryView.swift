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
        // UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).textColor = .black
        UITableView.appearance().backgroundColor = .red
    }
    
    var body: some View {
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
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.sunlight, Color.bluesky]),
                startPoint: .top, endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.vertical)
        )
        .scrollContentBackground(.hidden)
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
