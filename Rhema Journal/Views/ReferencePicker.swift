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
    @Binding var references: String
    @State private var parsedVerses: [String] = []
    @State private var debounceWorkItem: DispatchWorkItem?
    
    func validateBibleVerses(verse: String) -> [String] {
        RefParser.parseReferences(verse).map({$0.toString()})
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter Scripture references", text: $references)
                .onAppear() {
                    parsedVerses = validateBibleVerses(verse: references)
                }
                .onChange(of: references) { old, newValue in
                    // Cancel the previous work item if it exists
                    debounceWorkItem?.cancel()
                    
                    // Create a new work item that will fire after a delay
                    let workItem = DispatchWorkItem {
                        // Perform the validation task
                        let verses = validateBibleVerses(verse: newValue)
                        
                        // Dispatch back to the main queue to update the UI
                        DispatchQueue.main.async {
                            parsedVerses = verses
                        }
                    }
                    // Save the new work item
                    debounceWorkItem = workItem
                    
                    // Schedule the work item to run after a delay
                    DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5, execute: debounceWorkItem!)
                }
                .autocapitalization(.words)
                .disableAutocorrection(true)
            
            if (!parsedVerses.isEmpty) {
                Divider()
                HStack() {
                    ForEach(parsedVerses.indices, id: \.self) { index in
                        ReferencePill(reference: parsedVerses[index], font: .callout)
                    }
                }
            }
        }
        .padding()
    }
}
