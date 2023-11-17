/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that represent a card shown in the card gallery.
*/

import SwiftUI

struct JournalItemView<Content: View, S: ShapeStyle>: View {
    let backgroundStyle: S
    let action: () -> Void
    @ViewBuilder var label: Content

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                label
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 8);
            }
        }
        .backgroundStyle(backgroundStyle)
    }
}
