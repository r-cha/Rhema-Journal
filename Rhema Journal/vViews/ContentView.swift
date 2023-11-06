//
//  ContentView.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/5/23.
//

import SwiftUI
import SwiftData


struct CompletedEntry: View {
    @Bindable var entry: Entry

    var body: some View {
        NavigationView {
            ForEach(entry.promptResponses.indices, id: \.self) { index in
                VStack{
                    Text(entry.promptResponses[index].prompt)
                    Text(entry.promptResponses[index].response)
                }
            }
        }
    }
}


struct EntryView: View {
    @State private var selectedType = Style.lectio
    @State private var promptResponses: [PromptResponse] = Prompts[Style.lectio] ?? []

    var body: some View {
        NavigationView {
            Form {
                Picker("Type", selection: $selectedType) {
                    ForEach(Style.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }.onChange(of: selectedType) { old, newValue in
                    promptResponses = Prompts[newValue] ?? []
                }

                ForEach(promptResponses.indices, id: \.self) { index in
                    TextField(promptResponses[index].prompt, text: $promptResponses[index].response)
                }
                Button("Save Entry") {
                    
                }
            }
            .navigationBarTitle("New Entry")
        }
    }
}

struct EntriesView: View {
    @Query var entries: [Entry]

    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink(destination: CompletedEntry(entry: entry)) {
                    Text(entry.title())
                }
            }
            .navigationBarTitle("Entries")
        }
    }
}

struct ContentView: View {
    @Query var entries: [Entry]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        EntriesView()
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
    #if os(macOS)
        .frame(minWidth: 500, minHeight: 500)
    #endif
}
