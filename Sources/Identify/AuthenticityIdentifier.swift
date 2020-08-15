import Foundation

// MARK: Public Identification

/// Public identification and authenticity verification for cryptographic identities and their signed content.
///
/// - TODO: Elaborate...
/// - TODO: Also mention why RawRepresentable?
///

public protocol AuthenticityIdentifier: RawRepresentable
where Self.RawValue == Data {
    
    /// Test whether the signature was created by corresponding cryptographic identity, and for given content.
    ///
    /// The `AuthenticityIdentifier` always represents one and only `CryptoIdentity`,
    /// at the same time allowing to publically verify the authenticity of signatures generated by that  secret identity.
    ///
    /// - Parameters:
    ///     - signature: The checksum to be verified.
    ///     - content: The byte-string allegedely belonging to creator of the signature.
    ///
    /// - Note: Signatures take different shapes and forms, and often come from different data sources;
    ///   for this reason, any object conforming to `DataProtocol` may represent a signature.
    ///
    /// - Returns: The logical outcome of verification, `true` when the signature is indeed authentic for given content.
    ///
    
    func isAuthentic<S, C>(_ signature: S, of content: C) -> Bool
    where S: DataProtocol, C: DataProtocol
    
}
