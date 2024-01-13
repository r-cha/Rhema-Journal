import SwiftUI
import SwiftData

import BibleKit


struct EntryView: View {
    @Bindable var entry: Entry
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                BibleVersePicker(entry: entry)
            }
            .listRowBackground(Color.clear)
            .background(.ultraThinMaterial, in: RoundedRectangle(
                cornerRadius: 8, style: .continuous
            ))
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(entry.sortedResponses()) { response in
                    ResponseView(promptResponse: response)
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
                    try? modelContext.save()
                    dismiss()
                }
            }
        }
    }
}
