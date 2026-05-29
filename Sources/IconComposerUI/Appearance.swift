import SwiftUI

public enum Appearance {
    case light
    case dark
    case tinted
}

public extension Appearance {
    init(from colorScheme: ColorScheme) {
        switch colorScheme {
            case .light: self = .light
            case .dark: self = .dark
            @unknown default: self = .light
        }
    }
}

extension Appearance {
    var codable: IconComposerAppearance {
        switch self {
            case .light: .light
            case .dark: .dark
            case .tinted: .tinted
        }
    }
}
