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
    case twi = "TWI"
    case soap = "SOAP"
    case hear = "HEAR"
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
    Style.twi: [
        "Thanksgiving: Thank God for what He's done and who He is. Write down anything you are thankful for",
        "Worship: Agree with who He is. Focus on a particular attribute of His character",
        "Intercession: Agree with what He wants to do",
    ],
    Style.soap: [
        "Scripture: Copy down or paraphrase the passage",
        "Observation: What stands out to you?",
        "Application: What is the right response in your life to this passage?",
        "Prayer: Does this passage spur any prayer for yourself or someone else?",
    ],
    Style.hear: [
        "Highlight: What words or phrases seem to jump out at you?",
        "Explain: What does this passage mean to its original audience?",
        "Apply: What does this passage mean today, to you?",
        "Respond: How can you think or act differently in response to this passage?",
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
