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
    var font: Font = .caption
    
    var body: some View {
        Text(reference)
            .fontWeight(.light)
            .padding([.leading, .trailing], 4)
            .background(Capsule(style:.circular).fill(.thinMaterial))
            .overlay(
                Capsule(style:.circular)
                    .stroke(.ultraThickMaterial, lineWidth: 1) // Define the border color and width
            )
            .multilineTextAlignment(.center)
            .font(font)
    }
}

#Preview {
    ReferencePill(reference: "John 3:16")
}
