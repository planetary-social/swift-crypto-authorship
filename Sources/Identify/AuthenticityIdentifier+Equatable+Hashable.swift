import Foundation

public extension AuthenticityIdentifier {

    // Two authenticity identifiers are equal when their raw values are the same.

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    /// The hash of an identifier is obtained from its raw value.

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }

}
