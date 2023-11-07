/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Sample cards to use during development.
*/

struct SampleDeck {
    static var contents: [Entry] = [
        Entry(style: Style.dbs, promptResponses: Prompts[Style.dbs] ?? []),
        Entry(style: Style.lectio, promptResponses: Prompts[Style.lectio] ?? []),
        Entry(style: Style.none, promptResponses: Prompts[Style.none] ?? [])
    ]
}
