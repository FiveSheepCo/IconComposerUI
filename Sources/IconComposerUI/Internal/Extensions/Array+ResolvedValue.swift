import Foundation

extension Array {
    func resolvedValue<Value>(in appearance: IconComposerAppearance) -> Value? where Element == IconComposerSpecialization<Value> {
        first { $0.appearance == appearance }?.value
            ?? first { $0.appearance == nil }?.value
    }
}
