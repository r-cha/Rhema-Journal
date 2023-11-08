//
//  ReferencePill.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/8/23.
//

import SwiftUI

import BibleKit

struct ReferencePill: View {
    var reference: String

    var body: some View {
        Text(reference)
            .fontWeight(.light)
            .padding([.leading, .trailing], 4)
            .background(
                Rectangle()
                    .fill(Color.green.opacity(0.3))
                    .border(Color.green, width: 1)
                    .cornerRadius(2))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    ReferencePill(reference: "John 3:16")
}
