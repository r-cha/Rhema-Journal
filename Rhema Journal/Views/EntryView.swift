/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 A reusable view for content presented as a card visually.
 */

import SwiftUI

import BibleKit


struct EntryView: View {
    @Bindable var entry: Entry
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(entry: Entry) {
        self.entry = entry
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    var body: some View {
        Form {
            Section {
                BibleVersePicker(references: $entry.references)
            } header: {
                //Text("Scripture")
            }.listRowBackground(Color.clear
            ).background(.ultraThinMaterial, in: RoundedRectangle(
                cornerRadius: 8, style: .continuous
            ))
            
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
            .edgesIgnoringSafeArea(.all)
        )
        .listRowBackground(Color.clear)
        .background(.ultraThinMaterial, in: RoundedRectangle(
            cornerRadius: 8, style: .continuous
        ))
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(entry)
                    dismiss()
                }
            }
        }
    }
}
