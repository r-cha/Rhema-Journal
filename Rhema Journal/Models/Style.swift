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

func init_prompts(style: Style) -> [PromptResponse] {
    switch style {
    case .lectio:
        return [
            PromptResponse(prompt: "Read: What words or phrases seem to jump out at me?", order: 0),
            PromptResponse(prompt: "Reflect: What is God saying?", order: 1),
            PromptResponse(prompt: "Respond: What is the right response in my life to this truth?", order: 2),
            PromptResponse(prompt: "Rest: Sit quietly and allow God to work. When your mind wanders, recenter on the truth from Scripture.", order: 3)
        ].sorted { 
            Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
        }
    case .dbs:
        return [
            PromptResponse(prompt: "What does this passage tell me about God?", order: 0),
            PromptResponse(prompt: "What does this story tell me about people?", order: 1),
            PromptResponse(prompt: "What is the right response in my life to this truth?", order: 2)
        ].sorted {
            Int($0.order ?? Int.max) < Int($1.order ?? Int.max)
        }
    case .none:
        return [PromptResponse(prompt: "Notes", order: 0)]
    }
}
