import Foundation

// MARK: Proof of Content Authenticity

/// Consistent and verified proof of content authenticity.
///
/// - Note: The proof does not reveal the public identifier or any other correspondence with the author.
///   It is up to developer to establish such correspondence depending on the use case scenario.
///
/// - Attention: Since this is a concrete structure, `Data` is the only type it operates on.
///   Any `DataProtocol` conformant instances must be turned into `Data` before arriving to any of the proof's constructors;
///   Data encoding and casting is on purpose moved out of the proof's scope.
///

public struct AuthenticityProof {
    
    /// The proof consists of a byte-string content proven to be authentic with the signature.
    
    public let content, signature: Data

    /// Sign the content using author's cryptographic identity.
    ///
    /// The signature is freshly generated, thus safe to conclude that is authentic.
    ///
    /// - Parameters:
    ///     - content: The byte-string to be signed.
    ///     - author: The identity responsible for generating a signature.
    ///
    /// - Throws: An `Error` thrown by the underlying cryptographic implementation.
    ///
    
    public init<A>(of content: Data, from author: A) throws
    where A: CryptoIdentity {
        self.content = content
        self.signature = try author.signature(for: content)
    }

    /// Verify authorship of the content claimed by an identity recognized by public identifier.
    ///
    /// This method of verification uses an `AuthenticityIdentifier` to confirm the authorship.
    ///
    /// - Remark: Use this form to test whether the content belongs to someone you know.
    ///
    /// - Parameters:
    ///     - content: The byte-string allegedely belonging to creator of the signature, represented by the public identifier.
    ///     - signature: The checksum to be verified.
    ///     - publicIdentifier: Publically known representation of the wannabe author's cryptographic identity.
    ///
    /// - Returns: Nothing when either the `signature` is corrupted, or when the `publicIdentifier` does not
    /// represent the original author.
    ///
    
    public init?<I>(of content: Data, verifying signature: Data, using publicIdentifier: I)
    where I: AuthenticityIdentifier {
        guard publicIdentifier.isAuthentic(signature, of: content) else {
            #warning("Add a trace log...")
            return nil
        }
        
        self.content = content
        self.signature = signature
    }

    /// Verify if the author indeed signed given content.
    ///
    /// This method of verification uses an `AuthenticityIdentifier` to confirm the authorship.
    ///
    /// - Remark: Use this form to make sure no one tamperred with your own content.
    ///
    /// - Parameters:
    ///     - content: The byte-string allegedely belonging to creator of the signature, represented by the public identifier.
    ///     - signature: The checksum to be verified.
    ///     - author: Secret cryptographic identity claiming the authorship.
    ///
    /// - Returns: Nothing when either the `signature` is corrupted, or when someone else is the `author`.
    ///
    
    public init?<A>(of content: Data, verifying signature: Data, from author: A)
    where A: CryptoIdentity {
        self.init(of: content, verifying: signature, using: author.publicIdentifier)
    }

}
