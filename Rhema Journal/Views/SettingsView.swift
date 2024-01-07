//
//  SettingsView.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/10/23.
//

import SwiftUI

import SwiftData

struct SettingsView: View {
    private var _userDefaults: UserDefaults
    @State private var style: Style
    
    init() {
        self._userDefaults = UserDefaults()
        self.style = Style(rawValue: _userDefaults.string(forKey: "JournalPreference") ?? Style.lectio.rawValue)!
    }
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text("Select the journal style for new entries to your journal. Changing this settings does not affect previous entries.").font(.body)
                    Divider()
                    Picker("Journal Type", selection: $style) {
                        ForEach(Style.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }.onChange(of: style) {
                        _userDefaults.setValue(style.rawValue, forKey: "JournalPreference")
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {Spacer()}
                        Text("Prompts")
                            .font(.headline)
                        ForEach(StylePrompts[style] ?? [], id: \.self) { prompt in
                            Text(prompt)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(
                    cornerRadius: 8, style: .continuous
                ))
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
