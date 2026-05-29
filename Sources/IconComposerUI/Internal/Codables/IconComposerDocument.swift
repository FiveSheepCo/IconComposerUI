import SwiftUI

struct IconComposerDocument: Decodable {
    let fill: IconComposerFill?
    let fillSpecializations: [IconComposerSpecialization<IconComposerFill>]?
    let groups: [IconComposerGroup]

    func resolvedFill(for appearance: IconComposerAppearance) -> IconComposerFill? {
        fillSpecializations?.resolvedValue(in: appearance)
    }

    var visibleGroups: [IconComposerGroup] {
        groups.filter { !$0.isHidden }
    }

    enum CodingKeys: String, CodingKey {
        case fill
        case fillSpecializations = "fill-specializations"
        case groups
    }
}
