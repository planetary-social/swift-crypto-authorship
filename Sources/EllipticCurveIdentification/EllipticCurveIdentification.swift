import Logging
import Crypto

/// - TODO: Introduction.
/// - TODO: Bibliography and references.

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


