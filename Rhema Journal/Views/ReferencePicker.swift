//
//  ReferencePicker.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/7/23.
//

import Foundation
import SwiftUI

import BibleKit


struct BibleVersePicker: View {
    @State private var verseInput: String = ""
    @State private var parsedVerses: [String] = []

    var body: some View {
        TextField("Enter a Scripture reference", text: $verseInput)
            .onChange(of: verseInput) { old, newValue in
                parsedVerses = validateBibleVerses(verse: newValue)
            }
            .autocapitalization(.words)
            .disableAutocorrection(true)
        
        if (!parsedVerses.isEmpty) {
            HStack {
                ForEach(parsedVerses.indices, id: \.self) {index in
                    ReferencePill(reference: parsedVerses[index])
                }
            }
        }
    }
    
    func validateBibleVerses(verse: String) -> [String] {
        // Define the regular expression pattern for a Bible verse
        RefParser.parseReferences(verse).map({$0.toString()})
    }
}
