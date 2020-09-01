import Foundation

public extension AuthenticityIdentifier {

    // The hash of an identifier is obtained from its raw value.

    func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }

}
