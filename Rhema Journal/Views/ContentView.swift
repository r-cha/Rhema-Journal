/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main view that contains the majority of the app's content.
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var entries: [Entry]
    @State private var navigationPath: [Entry] = []
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack(path: $navigationPath) {
            JournalView(entries: entries) { entry in
                withAnimation { navigationPath.append(entry) }
            } addEntry: {
                let newEntry = Entry(style: Style.lectio, promptResponses: Prompts[Style.lectio] ?? [])
                modelContext.insert(newEntry)
                withAnimation {
                    navigationPath.append(newEntry)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
    #if os(macOS)
        .frame(minWidth: 500, minHeight: 500)
    #endif
}
