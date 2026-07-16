//
//  ObjectDetector.swift
//  TomatoDollQuestion
//
//  Created by 박정은 on 7/17/26.
//

import Vision
import CoreML

final class ObjectDetector {
    private var request: VNCoreMLRequest?

    /// (감지 여부, confidence)를 돌려줌
    var onResult: ((Bool, Float) -> Void)?

    init() {
        guard let model = try? TomatoDollDetector(configuration: MLModelConfiguration()).model,
              let visionModel = try? VNCoreMLModel(for: model) else {
            print("❌ 모델 로드 실패 — 모델 클래스 이름 확인")
            return
        }
        request = VNCoreMLRequest(model: visionModel) { [weak self] request, _ in
            self?.handleResults(request.results)
        }
        request?.imageCropAndScaleOption = .scaleFill
    }

    func detect(in pixelBuffer: CVPixelBuffer) {
        guard let request else { return }
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                            orientation: .right)
        try? handler.perform([request])
    }

    private func handleResults(_ results: [VNObservation]?) {
        guard let observations = results as? [VNRecognizedObjectObservation] else {
            onResult?(false, 0)
            return
        }
        // 디버그: 모든 감지 결과를 그대로 출력
//        for obs in observations {
//            if let label = obs.labels.first {
//                print("라벨: \(label.identifier) — confidence: \(label.confidence)")
//            }
//        }

        let best = observations
            .compactMap { obs -> Float? in
                obs.labels.first(where: { $0.identifier == "tomato-doll" })?.confidence
            }
            .max()

        if let confidence = best {
            onResult?(confidence > 0.8, confidence)
        } else {
            onResult?(false, 0)
        }
    }
}
