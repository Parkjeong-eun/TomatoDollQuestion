//
//  QuestionCardView.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import SwiftUI
import SwiftData

struct QuestionCardView: View {
    let question: String
    var onSave: (String) -> Void
    var onDismiss: () -> Void

    @State private var answer: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { onDismiss() }

            VStack(spacing: 20) {
                Text("오늘의 질문")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(question)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)

                TextField("답변을 입력하세요", text: $answer)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)

                Button {
                    guard !answer.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    onSave(answer)
                } label: {
                    Text("저장")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
                .disabled(answer.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(24)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 32)
        }
        .onAppear { isFocused = true }
    }
}
