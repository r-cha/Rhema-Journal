//
//  PromptSelector.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 1/16/24.
//

import SwiftUI

struct PromptSelector: View {
    private var _userDefaults: UserDefaults
    @State private var style: Style
    
    init() {
        self._userDefaults = UserDefaults()
        self.style = Style(rawValue: _userDefaults.string(forKey: "JournalPreference") ?? Style.lectio.rawValue)!
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Prompts").font(.headline)
            VStack(alignment: .leading) {
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
    }
}

#Preview {
    PromptSelector()
}
