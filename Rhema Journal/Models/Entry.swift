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
    
    init(style: Style, promptResponses: [PromptResponse], timestamp: Date = .now) {
        self.timestamp = timestamp
        self._style = style.rawValue
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


// MARK: Migration

struct JournalMigrationPlan: SchemaMigrationPlan {
    static let schemas: [VersionedSchema.Type] = [JournalVersionedSchema.self]
    static let stages: [MigrationStage] = []
}

struct JournalVersionedSchema: VersionedSchema {
    static let models: [any PersistentModel.Type] = [Entry.self]
    static let versionIdentifier: Schema.Version = .init(1, 0, 0)
}
