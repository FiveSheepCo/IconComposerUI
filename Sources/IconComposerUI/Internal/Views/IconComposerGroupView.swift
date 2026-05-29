import SwiftUI

struct IconComposerGroupView: View {
    let url: URL
    let group: IconComposerGroup
    let canvasSize: CGSize
    let appearance: IconComposerAppearance

    var body: some View {
        ZStack {
            ForEach(Array(group.visibleLayers.enumerated()), id: \.offset) { _, layer in
                IconComposerLayerView(
                    url: url,
                    layer: layer,
                    group: group,
                    canvasSize: canvasSize,
                    appearance: appearance
                )
            }
        }
        .opacity(group.resolvedOpacity(in: appearance))
        .scaleEffect(group.position?.scale ?? 1)
        .offset(group.position?.offset(for: canvasSize) ?? .zero)
        .blendMode(group.resolvedBlendMode(in: appearance))
    }
}
