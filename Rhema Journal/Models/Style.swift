//
//  Style.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 11/6/23.
//

import Foundation
import SwiftData


enum Style: String, CaseIterable {
    case lectio = "Lectio Divina"
    case dbs = "Discovery Bible Study"
    case none = "None"
}


let StylePrompts = [
    Style.lectio: [
        "Read: What words or phrases seem to jump out at you?",
        "Reflect: What is God saying?",
        "Respond: What is the right response in my life to this passage?",
        "Rest: Sit quietly and allow God to work. When your mind wanders, recenter on the truth from Scripture.",
    ],
    Style.dbs: [
        "What does this passage tell me about God?",
        "What does this story tell me about people?",
        "What is the right response in my life to this passage?",
    ],
    Style.none: [
        "Notes",
    ],
]


func init_prompts(style: Style) -> [PromptResponse] {
    var response: [PromptResponse] = []
    for (i, prompt) in StylePrompts[style]!.enumerated() {
        response.append(PromptResponse(prompt: prompt, order: i))
    }
    return response
}
