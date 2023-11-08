/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Variables that affect the design of the app.
*/

import SwiftUI

enum Design {
    static var galleryGridSize: GridItem.Size {
        .adaptive(minimum: 200)
    }

    static var galleryGridSpacing: Double {
        10
    }

    static var galleryItemPadding: Double {
        0
    }

    static var galleryButtonStyle: some PrimitiveButtonStyle {
        .plain
    }

    static var editFeatureEnabled: Bool {
        true
    }

    static var carouselCardButtonStyle: some PrimitiveButtonStyle {
        .plain
    }

    static var carouselCardHorizontalPadding: Double {
        8
    }

    static var carouselCardMaxWidth: Double {
        800
    }

    static var cardCornerRadius: Double {
        8
    }

    static var cardViewingFont: Font {
        .title
    }

}

extension Color {
    static let cardFront = Color("Card Front")
    static let cardBack = Color("Card Back")
    static let cardText = Color("Card Text")
}
