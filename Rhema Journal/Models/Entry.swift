//
//  Item.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/5/23.
//

import Foundation
import SwiftData

import BibleKit


var preDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE "
    return formatter
}


var postDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = ", MMMM d"
    return formatter
}

func prettyTime(time: Date) -> String {
   let calendar = Calendar.current
   var period: String
   switch calendar.component(.hour, from: time) {
   case 0...5:
       period = "Early Morning"
   case 5...10:
       period = "Morning"
   case 11...14:
       period = "Midday"
   case 15...17:
       period = "Afternoon"
   case 18...20:
       period = "Evening"
   case 21...24:
       period = "Night"
   default:
       period = ""
   }
   return preDateFormatter.string(from: time) + period + postDateFormatter.string(from: time)
}


@Model
final class Entry: Identifiable {
    var heading: String = ""
    var timestamp: Date

    var references: String = ""
    
    @Relationship(deleteRule: .cascade)
    var promptResponses: [PromptResponse]?
    
    @Transient var style: Style  {
        get { Style(rawValue: _style)! }
        set { _style = newValue.rawValue }
    }
    @Attribute var _style: Style.RawValue
    
    init(style: Style, references: String = "", timestamp: Date = .now) {
        self.heading = prettyTime(time: timestamp)
        self.timestamp = timestamp
        self._style = style.rawValue
        self.references = references
        self.promptResponses = init_prompts(style: style)
    }
    
    func title() -> String {
        return heading == "" ? prettyTime(time: self.timestamp) : heading
    }
    
    func sortedResponses() -> [PromptResponse] {
        return self.promptResponses?.sorted {
            Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
        } ?? []
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

