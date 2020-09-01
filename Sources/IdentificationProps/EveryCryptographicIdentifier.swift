import Foundation

@testable import Identify

extension UniversalProperties {

    /// Is this a cryptographic identifier (either an identity or public identifier)?
    ///
    /// Implementations of `CryptoIdentity` and  `AuthenticityIdentifier` should satisfy the following properties:
    ///
    /// - fixed-length;
    /// - conformant to `RawRepresentable`.
    ///

    struct EveryCryptographicIdentifier<Implementation: RawRepresentable & Hashable>
    where Implementation.RawValue == Data {

        /// A cryptographic identifier to be tested against these properties.

        let identifier: Implementation

        /// Expected size of the fixed-length key.

        let exactKeyByteCount: Int

        /// Key should be fixed-length.

        func alwaysTheSameExactByteCount() -> Bool {
            return identifier.rawValue.count == exactKeyByteCount
        }

        /// Cryptographic identifier can be represented as raw byte-string stored in `Data` object.

        func correctlyConformsToRawRepresentable() -> Bool {
            let tamperedSize = exactKeyByteCount - Int.random(in: 1...exactKeyByteCount)

            return
                Implementation(rawValue: identifier.rawValue.prefix(tamperedSize)) == nil &&
                Implementation(rawValue: identifier.rawValue)?.rawValue == identifier.rawValue
        }

        /// ...

        func correctlyConformsToEquatable(against otherIdentifier: Implementation) -> Bool {
            return
                identifier == identifier &&
                identifier != otherIdentifier
        }

        /// ...

        func correctlyConformsToHashable(against otherIdentifier: Implementation) -> Bool {
            return
                identifier.hashValue == identifier.hashValue &&
                identifier.hashValue != otherIdentifier.hashValue
        }

    }

}
