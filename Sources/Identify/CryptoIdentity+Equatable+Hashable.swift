import Foundation

public extension CryptoIdentity {

    /// Two cryptographic identities are equal when their public identifiers are the same.

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.publicIdentifier == rhs.publicIdentifier
    }

    /// Public identifier serves as a seed of the hash.

    func hash(into hasher: inout Hasher) {
        hasher.combine(publicIdentifier)
    }

    var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }

}
