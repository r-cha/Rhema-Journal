//
//  SettingsView.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/10/23.
//

import SwiftUI

import SwiftData

struct SettingsView: View {
    
    var body: some View {
        Form {
            Section {
                PromptSelector()
            }
            .listRowBackground(Color.clear)
            Section {
                IconSetter()
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Preferences")
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.sunlight, Color.bluesky]),
                startPoint: .top, endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.vertical)
        )
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SettingsView()
}
