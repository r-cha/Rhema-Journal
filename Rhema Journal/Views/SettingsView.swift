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
                Text("Select the journal style for new entries to your journal. Changing this settings does not affect previous entries.").font(.body)
                Picker("Journal Type", selection: $style) {
                    ForEach(Style.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }.onChange(of: style) {
                    _userDefaults.setValue(style.rawValue, forKey: "JournalPreference")
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Prompts")
                        .font(.headline)
                    ForEach(StylePrompts[style] ?? [], id: \.self) { prompt in
                        Text(prompt)
                    }
                }
            }
            //Section {
            //    Text("Export your entire journal as a .zip of .txt files.").font(.body)
            //    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            //        Text("Export")
            //    })
            //}
        }
        .navigationTitle("Preferences")
    }
}
