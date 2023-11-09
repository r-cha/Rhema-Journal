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

    var body: some View {
        TextField("Enter Scripture references", text: $references)
            .onChange(of: references) { old, newValue in
                // Cancel the previous work item if it exists
                debounceWorkItem?.cancel()
                
                // Create a new work item that will fire after a delay
                let workItem = DispatchWorkItem {
                    // Perform the heavy task on a background thread
                    let verses = self.validateBibleVerses(verse: newValue)
                    
                    // Dispatch back to the main queue to update the UI
                    DispatchQueue.main.async {
                        self.parsedVerses = verses
                    }
                }
                // Save the new work item
                debounceWorkItem = workItem
                
                // Schedule the work item to run after a delay on a background queue
                DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1, execute: workItem)
            }
            .autocapitalization(.words)
            .disableAutocorrection(true)
            .onAppear {
                // Perform any initialization logic here if needed
                self.parsedVerses = validateBibleVerses(verse: references)
            }
        
        if (!parsedVerses.isEmpty) {
            HStack {
                ForEach(parsedVerses.indices, id: \.self) { index in
                    ReferencePill(reference: parsedVerses[index])
                }
            }
        }
    }
    
    func validateBibleVerses(verse: String) -> [String] {
        RefParser.parseReferences(verse).map({$0.toString()})
    }
}
