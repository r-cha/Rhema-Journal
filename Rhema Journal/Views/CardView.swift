/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that represent a card shown in the card gallery.
*/

import SwiftUI

import BibleKit

struct CardView<Content: View>: View {
    let action: () -> Void
    @ViewBuilder var label: Content

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                label
                    .font(.title2)
                    .foregroundStyle(Color.accentColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .backgroundStyle(Color.white)
                    .padding(.bottom, 8)
            }
        }
    }
}

struct JournalLabelContent: View {
    let entry: Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.title())
            if let parsedVerses = Optional(RefParser.parseReferences(entry.references)) {
                if parsedVerses.count > 0 {
                    HStack {
                        ForEach(parsedVerses.indices, id: \.self) {index in
                            ReferencePill(reference: parsedVerses[index].toString())
                        }
                    }
                }
            }
            HStack {Spacer()}
        }
    }
}
