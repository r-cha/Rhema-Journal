//
//  Rhema_JournalApp.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/5/23.
//

import SwiftUI
import SwiftData

@main
struct Rhema_JournalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Entry.self)
    }
}
