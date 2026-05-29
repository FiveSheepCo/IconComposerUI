import SwiftUI

struct IconComposerFillView: View {
    let fill: IconComposerFill

    var body: some View {
        switch fill {
            case .automatic:
                LinearGradient(
                    colors: [Color.primary.opacity(0.20), Color.primary.opacity(0.08)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            case .solid(let color):
                color.swiftUIColor
            case .automaticGradient(let color, let orientation):
                LinearGradient(
                    colors: [
                        color.swiftUIColor.opacity(1.0),
                        color.swiftUIColor.opacity(0.72)
                    ],
                    startPoint: orientation.start.unitPoint,
                    endPoint: orientation.stop.unitPoint
                )
            case .linearGradient(let colors, let orientation):
                LinearGradient(
                    colors: colors.map(\.swiftUIColor),
                    startPoint: orientation.start.unitPoint,
                    endPoint: orientation.stop.unitPoint
                )
        }
    }
}
