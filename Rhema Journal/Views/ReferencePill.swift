//
//  ReferencePill.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/8/23.
//

import SwiftUI

import BibleKit

struct ReferencePill: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var reference: String

    var body: some View {
        Text(reference)
            .fontWeight(.light)
            .padding([.leading, .trailing], 4)
            .background(Capsule(style:.circular).fill(Color.green.opacity(colorScheme == .light ? 0.3 : 0.7)))
            .overlay(
                Capsule(style:.circular)
                    .stroke(Color.green, lineWidth: 1) // Define the border color and width
            )
            .multilineTextAlignment(.center)
            .font(.callout)
    }
}

#Preview {
    ReferencePill(reference: "John 3:16")
}
