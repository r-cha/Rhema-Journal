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
    
    private var _userDefaults: UserDefaults = UserDefaults()
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack(path: $navigationPath) {
            JournalView(entries: entries) { entry in
                withAnimation { navigationPath.append(entry) }
            } addEntry: {
                let style = Style(rawValue: _userDefaults.string(forKey: "JournalPreference") ?? Style.lectio.rawValue)
                let newEntry = Entry(style: style!)
                modelContext.insert(newEntry)
                withAnimation { navigationPath.append(newEntry) }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Rhema Journal")
                        .font(.largeTitle)
                        .fontDesign(.serif)
                        .foregroundStyle(Color.FG.gradient)
                }
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.sunlight, Color.bluesky]),
                    startPoint: .top, endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .scrollContentBackground(.hidden)
            .scrollClipDisabled()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
