/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Sample cards to use during development.
*/

import Foundation

import BibleKit


var seconds: Double = -86400

struct SampleDeck {
    static var contents: [Entry] = [
        Entry(style: Style.dbs, promptResponses: init_prompts(style: Style.dbs), references: "Rev 21:10", timestamp: Date(timeIntervalSinceNow: seconds)),
        Entry(style: Style.lectio, promptResponses: init_prompts(style: Style.lectio), references: "Ex 34", timestamp: Date(timeIntervalSinceNow: seconds*2)),
        Entry(style: Style.lectio, promptResponses: init_prompts(style: Style.lectio), references: "Psalm 4-12", timestamp: Date(timeIntervalSinceNow: seconds*8)),
        Entry(style: Style.none, promptResponses: init_prompts(style: Style.none), references: "Matthew 6:25-59", timestamp: Date(timeIntervalSinceNow: seconds*9))
    ]
}
