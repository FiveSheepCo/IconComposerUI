import SwiftUI

struct IconComposerGroup: Decodable {
    let blendMode: String?
    let blendModeSpecializations: [IconComposerSpecialization<String>]?
    let hidden: Bool?
    let layers: [IconComposerLayer]
    let opacity: Double?
    let opacitySpecializations: [IconComposerSpecialization<Double>]?
    let position: IconComposerPosition?
    let shadow: IconComposerShadow?
    let shadowSpecializations: [IconComposerSpecialization<IconComposerShadow>]?

    var isHidden: Bool {
        hidden == true
    }

    func resolvedBlendMode(in appearance: IconComposerAppearance) -> BlendMode {
        IconComposerBlendMode(blendModeSpecializations?.resolvedValue(in: appearance) ?? blendMode).blendMode
    }

    func resolvedOpacity(in appearance: IconComposerAppearance) -> Double {
        opacitySpecializations?.resolvedValue(in: appearance) ?? opacity ?? 1
    }

    func resolvedShadowOpacity(in appearance: IconComposerAppearance) -> Double {
        shadowSpecializations?.resolvedValue(in: appearance)?.opacity ?? shadow?.opacity ?? 0
    }

    var visibleLayers: [IconComposerLayer] {
        layers.filter { !$0.isHidden }
    }

    enum CodingKeys: String, CodingKey {
        case blendMode = "blend-mode"
        case blendModeSpecializations = "blend-mode-specializations"
        case hidden
        case layers
        case opacity
        case opacitySpecializations = "opacity-specializations"
        case position
        case shadow
        case shadowSpecializations = "shadow-specializations"
    }
}
