import Logging
import Crypto

/// CryptoKit's implementation of 25519 curves is a solid cryptographic identity.
///
/// - Note: Decentralised uniqueness guarranties of Ed25519 signing keys are high, even in context of very large networks;
/// - TODO: ^ References.
///
/// - Remark: Curve25519 already has `signature` compatible with `AuthenticityIdentifier`.
///
/// - TODO: Bibliography and other references.
///

public struct EllipticCurveIdentification {

    /// Module-level logging.
    ///
    /// Developers may use their own logger; default one is provided.
    ///
    
    public static var logger = Logger(label: "social.planetary.EllipticCurveIdentification")

    /// This implementation uses private key from Edward's Curve (variant 25519) as the cryptographic identity.
    
    public typealias Identity = Curve25519.Signing.PrivateKey
    
    /// Shorthand to access identity's public representation type.
    
    public typealias PublicIdentiifer = Identity.Identifier
    
}

internal var logger = EllipticCurveIdentification.logger
