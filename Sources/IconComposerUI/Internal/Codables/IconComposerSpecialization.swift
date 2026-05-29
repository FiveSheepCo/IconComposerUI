import SwiftUI

struct IconComposerSpecialization<Value: Decodable>: Decodable {
    let appearance: IconComposerAppearance?
    let value: Value?
}
