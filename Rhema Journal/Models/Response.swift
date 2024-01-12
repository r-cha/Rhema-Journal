//
//  Response.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/6/23.
//

import Foundation
import SwiftData


@Model
class PromptResponse: Identifiable {
    var entry: Entry?
    var id = UUID()
    var prompt: String
    var response: String
    var order: Int?

    init(prompt: String, order: Int? = nil) {
        self.prompt = prompt
        self.response = ""
        self.order = order
    }

    init(prompt: String, response: String) {
        self.prompt = prompt
        self.response = response
        self.order = nil
    }
}
