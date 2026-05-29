import SwiftUI

struct IconComposerColor {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    init?(_ string: String) {
        let colorSpace = string.split(separator: ":").first
        let components = string
            .split(separator: ":")
            .last?
            .split(separator: ",")
            .compactMap { Double($0) } ?? []

        if components.count == 2,
           colorSpace == "gray" || colorSpace == "extended-gray" {
            self.red = components[0]
            self.green = components[0]
            self.blue = components[0]
            self.alpha = components[1]
            return
        }

        guard components.count == 4 else { return nil }
        self.red = components[0]
        self.green = components[1]
        self.blue = components[2]
        self.alpha = components[3]
    }

    var swiftUIColor: Color {
        Color(.displayP3, red: red, green: green, blue: blue, opacity: alpha)
    }
}
