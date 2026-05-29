import SwiftUI

struct IconComposerLayerView: View {
    let url: URL
    let layer: IconComposerLayer
    let group: IconComposerGroup
    let canvasSize: CGSize
    let appearance: IconComposerAppearance

    #if canImport(AppKit)
    private var image: NSImage? {
        guard let imageName = layer.imageName else { return nil }
        return NSImage(contentsOf: url.appending(path: "Assets").appending(path: imageName))
    }
    #elseif canImport(UIKit)
    private var image: UIImage? {
        guard let imageName = layer.imageName else { return nil }
        return UIImage(contentsOfFile: url.appending(path: "Assets").appending(path: imageName).path(percentEncoded: false))
    }
    #endif

    var body: some View {
        Group {
            if let image {
                #if canImport(AppKit)
                let swiftUIImage = Image(nsImage: image)
                #elseif canImport(UIKit)
                let swiftUIImage = Image(uiImage: image)
                #endif
                let layerFill = layer.resolvedFill(in: appearance)

                ZStack {
                    if let layerFill,
                       !layerFill.preservesSourceArtwork {
                        IconComposerFillView(fill: layerFill)
                            .mask(layerImage(swiftUIImage))
                    } else {
                        layerImage(swiftUIImage)
                    }

                    if layer.isGlass(in: appearance) {
                        glassHighlight
                            .mask(layerImage(swiftUIImage))
                    }
                }
                .opacity(layer.resolvedOpacity(in: appearance))
                .scaleEffect(layer.position?.scale ?? 1)
                .offset(layer.position?.offset(for: canvasSize) ?? .zero)
                .blendMode(layer.resolvedBlendMode(in: appearance) ?? group.resolvedBlendMode(in: appearance))
                .shadow(
                    color: .black.opacity(group.resolvedShadowOpacity(in: appearance) * 0.35),
                    radius: max(canvasSize.width, canvasSize.height) * 0.035,
                    x: 0,
                    y: max(canvasSize.width, canvasSize.height) * 0.018
                )
            }
        }
    }

    private func layerImage(_ image: Image) -> some View {
        image
            .resizable()
            .antialiased(true)
            .interpolation(.high)
            .aspectRatio(contentMode: .fit)
    }

    private var glassHighlight: some View {
        LinearGradient(
            colors: [.white.opacity(0.65), .white.opacity(0.12), .clear],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .blendMode(.screen)
        .opacity(0.55)
    }
}
