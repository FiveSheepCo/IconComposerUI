import SwiftUI

struct IconComposerAppIcon: View {
    let url: URL
    let document: IconComposerDocument?
    let appearance: IconComposerAppearance

    init(url: URL, appearance: IconComposerAppearance) {
        self.url = url
        self.document = Self.loadDocument(from: url)
        self.appearance = appearance
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                IconComposerBackground(document: document, appearance: appearance)

                if let document {
                    ForEach(Array(document.visibleGroups.reversed().enumerated()), id: \.offset) { _, group in
                        IconComposerGroupView(url: url, group: group, canvasSize: geometry.size, appearance: appearance)
                            .saturation(appearance == .tinted ? 0 : 1)
                            .brightness(appearance == .tinted ? 0.75 : 0)
                            .contrast(appearance == .tinted ? 0.35 : 1)
                    }
                }

                LinearGradient(
                    colors: [.white.opacity(0.45), .white.opacity(0.05), .clear],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blendMode(.screen)
                .opacity(0.35)
            }
        }
    }

    private static func loadDocument(from url: URL) -> IconComposerDocument? {
        let iconJSON = url.appending(path: "icon.json")
        guard let data = try? Data(contentsOf: iconJSON) else { return nil }
        return try? JSONDecoder().decode(IconComposerDocument.self, from: data)
    }
}
