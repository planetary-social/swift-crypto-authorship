///
import Foundation
import Identify
import Logging
import Crypto

// MARK: Public Identification

extension Curve25519.Signing.PublicKey: AuthenticityIdentifier {

    public typealias RawValue = Data
    
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
    
    public func isAuthentic<S, C>(_ signature: S, of content: C) -> Bool
    where S: DataProtocol, C: DataProtocol {
        return self.isValidSignature(signature, for: content)
    }
    
}
