import Foundation

// MARK: Secret Cryptographic Identity

/// Cryptographic identities provide means of signing and authenticating information.
///
/// - TODO: Elaborate...
/// - TODO: Explain the reasons behind requiring RawRepresentable scoped over Data.
///

public protocol CryptoIdentity: RawRepresentable
where Self.RawValue == Data {
    
    /// Public identification method compatible with implemented type of identity.

    associatedtype Identifier: AuthenticityIdentifier
        
    /// Identify this identity by their public authenticity identifier.
    
    var publicIdentifier: Identifier { get }

    /// Generate unique cryptographic identity.
    ///
    /// As an implementer, favor implementations without the explicit need of any central authority.
    ///
    /// - Note: Uniqueness is a spectrum, in small networks there might be no problem with low uniqueness guarrantees,
    ///   while the large ones may expect uniqueness guarranties (preferrably, formally proven) up to certain level of confidence.
    ///
    /// - TODO: Explain why the parameter-free init is important and necessary here.
    ///
    
    init() throws
    
    /// Unique signature can be calculated for any object conforming to `DataProtocol`.
    ///
    /// - Parameter content: The byte-string to be signed.
    ///
    /// - Returns: A `Data` object containing the calculated signature.
    ///
    /// - Throws: An `Error` thrown by the underlying cryptographic implementation.
    ///
    
    func signature<C>(for content: C) throws -> Data
    where C: DataProtocol
    
}
