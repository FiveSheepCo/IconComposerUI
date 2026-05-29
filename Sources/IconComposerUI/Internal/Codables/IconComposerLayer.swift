import SwiftUI

struct IconComposerLayer: Decodable {
    let blendMode: String?
    let blendModeSpecializations: [IconComposerSpecialization<String>]?
    let fill: IconComposerFill?
    let fillSpecializations: [IconComposerSpecialization<IconComposerFill>]?
    let glass: Bool?
    let glassSpecializations: [IconComposerSpecialization<Bool>]?
    let hidden: Bool?
    let imageName: String?
    let opacity: Double?
    let opacitySpecializations: [IconComposerSpecialization<Double>]?
    let position: IconComposerPosition?

    func isGlass(in appearance: IconComposerAppearance) -> Bool {
        glassSpecializations?.resolvedValue(in: appearance) ?? glass ?? false
    }

    var isHidden: Bool {
        hidden == true
    }

    func resolvedBlendMode(in appearance: IconComposerAppearance) -> BlendMode? {
        guard let blendMode = blendModeSpecializations?.resolvedValue(in: appearance) ?? blendMode else {
            return nil
        }
        return IconComposerBlendMode(blendMode).blendMode
    }

    func resolvedFill(in appearance: IconComposerAppearance) -> IconComposerFill? {
        fillSpecializations?.resolvedValue(in: appearance) ?? fill
    }

    func resolvedOpacity(in appearance: IconComposerAppearance) -> Double {
        opacitySpecializations?.resolvedValue(in: appearance) ?? opacity ?? 1
    }

    enum CodingKeys: String, CodingKey {
        case blendMode = "blend-mode"
        case blendModeSpecializations = "blend-mode-specializations"
        case fill
        case fillSpecializations = "fill-specializations"
        case glass
        case glassSpecializations = "glass-specializations"
        case hidden
        case imageName = "image-name"
        case opacity
        case opacitySpecializations = "opacity-specializations"
        case position
    }
}
