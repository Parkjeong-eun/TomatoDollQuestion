//
//  AnswerEntry.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import Foundation
import SwiftData

@Model
final class AnswerEntry {
    var question: String
    var answer: String
    var date: Date

    init(question: String, answer: String, date: Date = .now) {
        self.question = question
        self.answer = answer
        self.date = date
    }
}
