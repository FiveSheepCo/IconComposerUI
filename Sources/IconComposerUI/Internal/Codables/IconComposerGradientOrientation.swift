import Foundation

struct IconComposerGradientOrientation: Decodable {
    static let `default` = IconComposerGradientOrientation(
        start: IconComposerPoint(x: 0.5, y: 0),
        stop: IconComposerPoint(x: 0.5, y: 0.7)
    )

    let start: IconComposerPoint
    let stop: IconComposerPoint
}
