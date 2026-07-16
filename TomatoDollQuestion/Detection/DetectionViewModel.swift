//
//  DetectionViewModel.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import Foundation
import Combine

final class DetectionViewModel: ObservableObject {
    
    @Published var isDetected = false
    @Published var confidence: Float = 0
    @Published var showQuestionCard = false
    @Published var currentQuestion: String = ""

    let camera = CameraManager()
    private let detector = ObjectDetector()
    private var isProcessing = false
    private var detectionStartTime: Date?
    private let requiredDuration: TimeInterval = 1.0

    init() {
        camera.onFrame = { [weak self] pixelBuffer in
            guard let self, !self.isProcessing else { return }
            self.isProcessing = true
            self.detector.detect(in: pixelBuffer)
        }
        detector.onResult = { [weak self] detected, confidence in
            DispatchQueue.main.async {
                self?.handle(detected: detected, confidence: confidence)
            }
        }
    }

    private func handle(detected: Bool, confidence: Float) {
        isDetected = detected
        self.confidence = confidence
        isProcessing = false

        guard detected else {
            detectionStartTime = nil
            return
        }

        guard !showQuestionCard else { return }

        if detectionStartTime == nil {
            detectionStartTime = Date()
        } else if let start = detectionStartTime,
                  Date().timeIntervalSince(start) >= requiredDuration {
            currentQuestion = QuestionProvider.randomQuestion()
            showQuestionCard = true
            detectionStartTime = nil
        }
    }

    func dismissCard() {
        showQuestionCard = false
    }
}
