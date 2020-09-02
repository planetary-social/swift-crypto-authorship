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
            return isAuthenticProof(of: exampleContent, from: author)
        }

        /// ...

        func invalidWithDifferentContent(anotherContent: Data) -> Bool {
            return !isAuthenticProof(of: anotherContent, from: author)
        }

        /// ...

        func invalidWithSomeoneElseThanAuthor(forger: SubjectIdentity) -> Bool {
            return !isAuthenticProof(of: exampleContent, from: forger)
        }

        ///

        private func isAuthenticProof(of content: Data, from author: SubjectIdentity) -> Bool {
            guard let signature = self.signature else { return false }
            return AuthenticityProof(of: content, verifying: signature, from: author) != nil
        }

    }

}
