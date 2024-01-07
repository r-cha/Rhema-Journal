//
//  MaterialSection.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 1/7/24.
//

import SwiftUI

struct MaterialSection<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        Section{
            content
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(
                    .ultraThinMaterial, in: RoundedRectangle(
                        cornerRadius: 8, style: .continuous
                    )
                )
        }
    }
}

#Preview {
    Form {
        Section {
            Text("Hello")
        }
        MaterialSection() {
            Text("Hello")
            Text("World!")
        }
    }
    .listRowBackground(Color.clear)
    .scrollContentBackground(.hidden)
}
