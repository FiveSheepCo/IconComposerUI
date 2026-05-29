import Foundation

enum IconComposerFill: Decodable {
    case automatic
    case solid(IconComposerColor)
    case automaticGradient(IconComposerColor, IconComposerGradientOrientation)
    case linearGradient([IconComposerColor], IconComposerGradientOrientation)

    init(from decoder: Decoder) throws {
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            if let color = IconComposerColor(stringValue) {
                self = .solid(color)
            } else {
                self = .automatic
            }
            return
        }

        let container = try decoder.container(keyedBy: IconComposerFillKey.self)
        let orientation = (try? container.decode(IconComposerGradientOrientation.self, forKey: .orientation)) ?? .default

        if let solid = try? container.decode(String.self, forKey: .solid),
           let color = IconComposerColor(solid) {
            self = .solid(color)
        } else if let automaticGradient = try? container.decode(String.self, forKey: .automaticGradient),
                  let color = IconComposerColor(automaticGradient) {
            self = .automaticGradient(color, orientation)
        } else if let linearGradient = try? container.decode([String].self, forKey: .linearGradient) {
            let colors = linearGradient.compactMap(IconComposerColor.init)
            self = colors.isEmpty ? .automatic : .linearGradient(colors, orientation)
        } else {
            self = .automatic
        }
    }

    var preservesSourceArtwork: Bool {
        switch self {
            case .automatic: true
            case .solid, .automaticGradient, .linearGradient: false
        }
    }
}

struct IconComposerFillKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }

    static let automaticGradient = IconComposerFillKey(stringValue: "automatic-gradient")!
    static let linearGradient = IconComposerFillKey(stringValue: "linear-gradient")!
    static let orientation = IconComposerFillKey(stringValue: "orientation")!
    static let solid = IconComposerFillKey(stringValue: "solid")!
}
