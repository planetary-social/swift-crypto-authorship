///
import Foundation
import Logging
import Crypto
import Identify

// MARK: Cryptographic Identity

extension Curve25519.Signing.PrivateKey: CryptoIdentity {
    
    /// Ed25519 signing keys come in pairs, the public keys serves as an authenticity identifier.
    
    public typealias Identifier = Curve25519.Signing.PublicKey
    
    public typealias RawValue = Data

    public var publicIdentifier: Identifier {
        return publicKey
    }

    public var rawValue: Data {
        return rawRepresentation
    }

    public init?(rawValue: Data) {
        do {
            try self.init(rawRepresentation: rawValue)
        } catch(let error) {
            logger.warning("invalid raw data: \(error)")
            return nil
        }
    }

    // Already implemented by CryptoKit:
    //
    //     public func signature<C>(for content: C) throws -> Data
    //     where C: DataProtocol
    //

}
