import SwiftUI

struct IconComposerPosition: Decodable {
    let scale: Double?
    let translationInPoints: [Double]?

    func offset(for canvasSize: CGSize) -> CGSize {
        guard let translationInPoints, translationInPoints.count == 2 else {
            return .zero
        }

        return CGSize(
            width: translationInPoints[0] / 1024 * canvasSize.width,
            height: translationInPoints[1] / 1024 * canvasSize.height
        )
    }

    enum CodingKeys: String, CodingKey {
        case scale
        case translationInPoints = "translation-in-points"
    }
}
