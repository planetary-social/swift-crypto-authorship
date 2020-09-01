import Foundation

public extension CryptoIdentity {

    /// Public identifier serves as a seed of the hash.

    func hash(into hasher: inout Hasher) {
        publicIdentifier.hash(into: &hasher)
    }

}
