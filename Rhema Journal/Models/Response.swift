//
//  Response.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/6/23.
//

import Foundation
import SwiftData


@Model
class PromptResponse {
    var id = UUID()
    var prompt: String
    var response: String

    init(prompt: String) {
        self.prompt = prompt
        self.response = ""
    }

    init(prompt: String, response: String) {
        self.prompt = prompt
        self.response = response
    }
}
