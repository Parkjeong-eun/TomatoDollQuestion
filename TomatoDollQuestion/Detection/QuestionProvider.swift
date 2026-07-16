//
//  QuestionProvider.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import Foundation

enum QuestionProvider {
    static let questions: [String] = {
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let loaded = try? JSONDecoder().decode([String].self, from: data),
              !loaded.isEmpty else {
            print("❌ Questions.json 로드 실패")
            return ["오늘 하루는 어땠나요?"]  // 폴백 질문
        }
        return loaded
    }()

    static func randomQuestion() -> String {
        questions.randomElement() ?? "오늘 하루는 어땠나요?"
    }
}
