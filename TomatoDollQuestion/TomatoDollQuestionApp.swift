//
//  TomatoDollQuestionApp.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import SwiftUI
import SwiftData

@main
struct TomatoDollQuestionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: AnswerEntry.self)
    }
}
