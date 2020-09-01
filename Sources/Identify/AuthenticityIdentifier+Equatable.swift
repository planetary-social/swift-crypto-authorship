import Foundation

public extension AuthenticityIdentifier {

    // Two authenticity identifiers are equal when their raw values are the same.

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

}
