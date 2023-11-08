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
    @Binding var ref: Reference
    
    init(ref: Binding<Reference>) {
        self._ref = ref
    }
    
    // Computed properties to get the chapters and verses based on the current selection
    var chapters: [Int] {
        let bookChapters = BibleData.lastVerse[ref.bookNumber ?? 0]
        return Array(1...bookChapters.count)
    }
    
    var verses: [Int] {
        let bookChapters = BibleData.lastVerse[ref.bookNumber ?? 0]
        let chapterVerses = bookChapters[ref.endChapterNumber ?? 0]
        return Array(1...chapterVerses)
    }
    
    var body: some View {
        HStack {
            // Book Picker
            Picker("Book", selection: $ref.bookNumber) {
                ForEach(BibleData.bookNames, id: \.self) { index in
                    Text(index[2]) // Full book name
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 200)
            
            // Chapter Picker
            Picker("Chapter", selection: $ref.startChapter.chapterNumber) {
                ForEach(chapters, id: \.self) { chapter in
                    Text("\(chapter)").tag(chapter - 1) // Chapters are 1-indexed
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: ref.bookNumber!) { old, newValue in
                ref = Reference(book: BibleData.bookNames[newValue][2])
            }
            
            // Verse Picker
            Picker("Verse", selection: $ref.startVerseNumber) {
                ForEach(verses, id: \.self) { verse in
                    Text("\(verse)").tag(verse - 1) // Verses are 1-indexed
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: ref.startChapter.chapterNumber) { old, newValue in
                ref = Reference(book: ref.book, startChapter: newValue)
            }
        }
        .frame(height: 125)
    }
}
