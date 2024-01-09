import SwiftUI

import BibleKit


struct EntryView: View {
    @Bindable var entry: Entry
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    init(entry: Entry) {
        self.entry = entry
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    var body: some View {
        Form {
            Section {
                BibleVersePicker(references: $entry.references)
            }
            .listRowBackground(Color.clear)
            .background(.ultraThinMaterial, in: RoundedRectangle(
                cornerRadius: 8, style: .continuous
            ))
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(entry.promptResponses.sorted {
                    Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
                }, id: \.self) { response in
                    ResponseView(promptResponse: response)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(
                        cornerRadius: 8, style: .continuous
                    ))
                }
            }
            .listRowBackground(Color.clear)
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
