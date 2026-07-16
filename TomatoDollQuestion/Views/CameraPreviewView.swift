//
//  CameraPreviewView.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import SwiftUI
import SwiftData

struct CameraPreviewView: View {
    @StateObject private var viewModel = DetectionViewModel()
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ZStack(alignment: .top) {
            CameraPreviewLayer(session: viewModel.camera.session)
                .ignoresSafeArea()
                .onAppear { viewModel.camera.start() }
                .onDisappear { viewModel.camera.stop() }

            Text(viewModel.isDetected
                 ? "🍅 감지됨 (\(Int(viewModel.confidence * 100))%)"
                 : "인형을 비춰보세요")
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: Capsule())
                .padding(.top, 20)

            if viewModel.showQuestionCard {
                QuestionCardView(
                    question: viewModel.currentQuestion,
                    onSave: { answer in
                        let entry = AnswerEntry(question: viewModel.currentQuestion, answer: answer)
                        modelContext.insert(entry)
                        viewModel.dismissCard()
                    },
                    onDismiss: { viewModel.dismissCard() }
                )
            }
        }
    }
}
