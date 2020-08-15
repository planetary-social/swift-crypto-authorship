import Foundation
import Identify

enum Fakes {
    
    /// ...
    
    struct IdentityWithAlwaysFailingSignature: CryptoIdentity {

        public typealias Identifier = IdentifierWithAlwaysFailingAuthenticityCheck
        
        var publicIdentifier: Identifier = Identifier()
        
        var rawValue = Data()

        init?(rawValue: Data) { }
        
        init() throws { }

        func signature<C>(for content: C) throws -> Data where C: DataProtocol {
            throw Failure.expected
        }

    }
    
    /// ...
    
    struct IdentifierWithAlwaysFailingAuthenticityCheck: AuthenticityIdentifier {
    
        var rawValue = Data()

        init?(rawValue: Data) { }
        
        init() { }
        
        func isAuthentic<S, C>(_ signature: S, of content: C) -> Bool
        where S: DataProtocol, C: DataProtocol {
            return false
        }
        
    }
    
    /// ...
    
    enum Failure: Error {
        case expected
    }

}
