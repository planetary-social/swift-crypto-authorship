import Foundation
import Identify

extension UniversalProperties {
    
    /// - TODO: Documentation...
    
    struct EveryAuthenticityProof<SubjectIdentity: CryptoIdentity> {
        
        /// ...
        
        let author: SubjectIdentity

        /// ...
        
        let exampleContent: Data

        /// ...
        
        private var proof: AuthenticityProof? {
            return try? AuthenticityProof(of: exampleContent, from: author)
        }
        
        /// ...
        
        private var signature: Data? {
            return proof?.signature
        }
        
        /// ...
        
        func generatesCorrectly() -> Bool {
            return proof != nil
        }

        /// ...
        
        func validWithTheSameAuthorAndContent() -> Bool {
            guard let s = self.signature else { return false }
            return
                AuthenticityProof(of: exampleContent, verifying: s, from: author) != nil &&
                AuthenticityProof(of: exampleContent, verifying: s, using: author.publicIdentifier) != nil
        }

        /// ...
        
        func invalidWithDifferentContent(anotherContent: Data) -> Bool {
            guard let s = self.signature else { return false }
            return
                AuthenticityProof(of: anotherContent, verifying: s, from: author) == nil &&
                AuthenticityProof(of: exampleContent, verifying: s, from: author) != nil &&
                AuthenticityProof(of: anotherContent, verifying: s, using: author.publicIdentifier) == nil &&
                AuthenticityProof(of: exampleContent, verifying: s, using: author.publicIdentifier) != nil
        }

        /// ...
        
        func invalidWithSomeoneElseThanAuthor(forger: SubjectIdentity) -> Bool {
            guard let s = self.signature else { return false }
            return
                AuthenticityProof(of: exampleContent, verifying: s, from: forger) == nil &&
                AuthenticityProof(of: exampleContent, verifying: s, using: forger.publicIdentifier) == nil
        }

    }
    
}
