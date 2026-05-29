import Foundation
import SwiftUI

public struct AppIcon: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let url: URL
    let size: Double
    let appearance: Appearance?
    
    private var resolvedAppearance: Appearance {
        appearance ?? Appearance(from: colorScheme)
    }
    
    public init(url: URL, size: Double, appearance: Appearance? = nil) {
        self.url = url
        self.size = size
        self.appearance = appearance
    }

    public var body: some View {
        Group {
            if #available(iOS 26, macOS 26, *) {
                IconComposerAppIcon(url: url, appearance: resolvedAppearance.codable)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: size * 0.223, style: .continuous))
                    .glassEffect(.clear, in: .rect(cornerRadius: size * 0.223))
            } else {
                IconComposerAppIcon(url: url, appearance: resolvedAppearance.codable)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: size * 0.223, style: .continuous))
            }
        }
    }
}

#Preview {
    let icons: [String] = [
        "ThaiVisaTracker.icon",
        "MisterKeyboard.icon",
        "Xpolyglot2.icon",
    ]
    VStack(spacing: 16) {
        ForEach(icons, id: \.self) { icon in
            if let url = Bundle.module.resourceURL?.appending(path: "Resources/\(icon)") {
                HStack(spacing: 0) {
                    AppIcon(url: url, size: 128, appearance: .light)
                        .padding(16)
                        .background(Color(white: 1))
                    
                    AppIcon(url: url, size: 128, appearance: .dark)
                        .padding(16)
                        .background(Color(white: 0))
                    
                    AppIcon(url: url, size: 128, appearance: .tinted)
                        .padding(16)
                        .background(Color(white: 0.5))
                }
                .clipShape(.rect(cornerRadius: 28))
                .shadow(radius: 16)
            } else {
                Text(verbatim: "Resource not found!")
            }
        }
    }
    .scenePadding()
}
