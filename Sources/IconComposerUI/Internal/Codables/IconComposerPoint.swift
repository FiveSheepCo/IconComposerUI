import SwiftUI

struct IconComposerPoint: Decodable {
    let x: Double
    let y: Double

    var unitPoint: UnitPoint {
        UnitPoint(x: x, y: y)
    }
}
