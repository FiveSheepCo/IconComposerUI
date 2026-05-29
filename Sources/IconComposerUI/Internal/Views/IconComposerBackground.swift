import SwiftUI

struct IconComposerBackground: View {
    let document: IconComposerDocument?
    let appearance: IconComposerAppearance
    
    var body: some View {
        switch appearance {
            case .light:
                if let fill = document?.resolvedFill(for: appearance) ?? document?.fill {
                    IconComposerFillView(fill: fill)
                } else {
                    LinearGradient(
                        colors: [Color(white: 1.0), Color(white: 0.95)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            case .dark:
                if let fill = document?.resolvedFill(for: appearance) {
                    IconComposerFillView(fill: fill)
                } else {
                    LinearGradient(
                        colors: [Color(white: 0.1), Color(white: 0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            case .tinted:
                Color.clear
        }
    }
}
