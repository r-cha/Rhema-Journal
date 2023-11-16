/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main view that contains the majority of the app's content.
*/

import SwiftUI
import SwiftData

import BibleKit

struct ContentView: View {
    @Query(
        sort: [SortDescriptor(\Entry.timestamp, order: .reverse)]
    ) private var entries: [Entry]
    @State private var navigationPath: [Entry] = []
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    private var _userDefaults: UserDefaults = UserDefaults()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            JournalView(entries: entries) { entry in
                withAnimation { navigationPath.append(entry) }
            } addEntry: {
                let newEntry = Entry(
                    style: Style.lectio,
                    promptResponses: init_prompts(
                        style: Style(rawValue: _userDefaults.string(forKey: "JournalPreference") ?? Style.lectio.rawValue)!
                    ))
                modelContext.insert(newEntry)
                withAnimation { navigationPath.append(newEntry) }
            } deleteEntry: { offsets in
                offsets.forEach { index in
                    let entry = entries[index]
                    modelContext.delete(entry)
                }
                try? modelContext.save()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Rhema Journal").font(.largeTitle).fontDesign(.serif)
                }
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
