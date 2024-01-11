//
//  Item.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/5/23.
//

import Foundation
import SwiftData

import BibleKit


var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMMM d"
    return formatter
}


@Model
final class Entry {
    var timestamp: Date
    var references: String = ""
    var promptResponses: [PromptResponse]
    
    @Transient var style: Style  {
        get { Style(rawValue: _style)! }
        set { _style = newValue.rawValue }
    }
    @Attribute var _style: Style.RawValue
    
    init(style: Style, promptResponses: [PromptResponse], references: String = "", timestamp: Date = .now) {
        self.timestamp = timestamp
        self._style = style.rawValue
        self.references = references
        self.promptResponses = promptResponses
    }
    
    func title() -> String {
        return dateFormatter.string(from: self.timestamp)
    }
    
    func sortedResponses() -> [PromptResponse] {
        return self.promptResponses.sorted {
            Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
        }
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

extension Reference: Equatable {
    public static func == (lhs: BibleKit.Reference, rhs: BibleKit.Reference) -> Bool {
        lhs.bookNumber == rhs.bookNumber &&
        lhs.endChapterNumber == rhs.endChapterNumber &&
        lhs.startVerseNumber == rhs.startVerseNumber
    }
}

// MARK: Migration

struct EntryMigrationPlan: SchemaMigrationPlan {
    static let schemas: [VersionedSchema.Type] = [EntryVersionedSchema.self]
    static let stages: [MigrationStage] = []
}

struct EntryVersionedSchema: VersionedSchema {
    static let models: [any PersistentModel.Type] = [Entry.self]
    static let versionIdentifier: Schema.Version = .init(1, 0, 0)
}
