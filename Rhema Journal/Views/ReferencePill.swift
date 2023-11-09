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
            .background(Capsule().fill(Color.green.opacity(colorScheme == .light ? 0.3 : 0.7)))
            .multilineTextAlignment(.center)
            .font(.title3)
    }
}

#Preview {
    ReferencePill(reference: "John 3:16")
}
