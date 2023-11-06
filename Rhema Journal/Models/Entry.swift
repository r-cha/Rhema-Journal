//
//  Item.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/5/23.
//

import Foundation
import SwiftData


var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMMM d"
    return formatter
}


@Model
final class Entry {
    var timestamp: Date
    var promptResponses: [PromptResponse]
    
    @Transient var style: Style  {
        get { Style(rawValue: _style)! }
        set { _style = newValue.rawValue }
    }
    
    @Attribute var _style: Style.RawValue
    
    init(entryType: Style, promptResponses: [PromptResponse]) {
        self.timestamp = Date()
        self._style = entryType.rawValue
        self.promptResponses = promptResponses
    }
    
    func title() -> String {
        return dateFormatter.string(from: self.timestamp)
    }
}



extension Entry: Hashable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.timestamp == rhs.timestamp &&
        lhs.style == rhs.style &&
        lhs.promptResponses == rhs.promptResponses
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
        hasher.combine(style)
        hasher.combine(promptResponses)
    }
}
