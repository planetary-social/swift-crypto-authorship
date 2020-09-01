import Foundation

public extension CryptoIdentity {

    /// Two cryptographic identities are equal when their public identifiers are the same.

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.publicIdentifier == rhs.publicIdentifier
    }

}
