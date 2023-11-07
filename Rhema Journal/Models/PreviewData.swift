/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Sample cards to use during development.
*/

import Foundation

var seconds: Double = -86400

struct SampleDeck {
    static var contents: [Entry] = [
        Entry(style: Style.dbs, promptResponses: init_prompts(style: Style.dbs), timestamp: Date(timeIntervalSinceNow: seconds)),
        Entry(style: Style.lectio, promptResponses: init_prompts(style: Style.lectio), timestamp: Date(timeIntervalSinceNow: seconds*2)),
        Entry(style: Style.none, promptResponses: init_prompts(style: Style.none), timestamp: Date(timeIntervalSinceNow: seconds*3)),
        Entry(style: Style.dbs, promptResponses: init_prompts(style: Style.dbs), timestamp: Date(timeIntervalSinceNow: seconds*4)),
        Entry(style: Style.lectio, promptResponses: init_prompts(style: Style.lectio), timestamp: Date(timeIntervalSinceNow: seconds*5)),
        Entry(style: Style.none, promptResponses: init_prompts(style: Style.none), timestamp: Date(timeIntervalSinceNow: seconds*6)),
        Entry(style: Style.dbs, promptResponses: init_prompts(style: Style.dbs), timestamp: Date(timeIntervalSinceNow: seconds*7)),
        Entry(style: Style.lectio, promptResponses: init_prompts(style: Style.lectio), timestamp: Date(timeIntervalSinceNow: seconds*8)),
        Entry(style: Style.none, promptResponses: init_prompts(style: Style.none), timestamp: Date(timeIntervalSinceNow: seconds*9))
    ]
}
