import SwiftUI

struct IconComposerBlendMode {
    let rawValue: String?

    init(_ rawValue: String?) {
        self.rawValue = rawValue
    }

    var blendMode: BlendMode {
        switch rawValue {
            case "darken": .darken
            case "hard-light": .hardLight
            case "lighten": .lighten
            case "multiply": .multiply
            case "normal", nil: .normal
            case "overlay": .overlay
            case "plus-darker": .plusDarker
            case "plus-lighter": .plusLighter
            case "screen": .screen
            case "soft-light": .softLight
            default: .normal
        }
    }
}
