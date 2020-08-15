import Foundation
import Identify
import Combine

// MARK: Combine Verifiably Authentic Information

public extension Publishers {

    /// ...
    
    struct Authentic<Upstream, AuthorIdentifier>: Publisher
    where Upstream: Publisher, Upstream.Failure == Never, Upstream.Output == SignedInformation,
          AuthorIdentifier: AuthenticityIdentifier {

        /// ...
        
        public typealias Failure = AuthenticationError

        /// ...
        
        public typealias Output = Data
                        
        /// ...
        
        public let upstream: Upstream

        /// ...
        
        public let authorIdentifier: AuthorIdentifier
        
        /// ...
        
        private let downstream: AnyPublisher<Output, Failure>

        /// ...
        
        public init(upstream: Upstream, using authorIdentifier: AuthorIdentifier) {
            self.upstream = upstream
            self.authorIdentifier = authorIdentifier
            
            // Verify the authenticity of each signed message from the upstream,
            // return the content only if authentic, otherwise fail:
            self.downstream =
                self.upstream
                    .tryMap { information in
                        guard
                            let proof = AuthenticityProof(of: information.content,
                                                          verifying: information.signature,
                                                          using: authorIdentifier)
                        else {
                            throw Failure.corruptedContentSignature
                        }
                        
                        return proof.content
                    }
                    .mapError { error in error as! Failure } // XXX: The casting here should never fail!
                    .eraseToAnyPublisher()
        }
        
        /// ...
        
        public func receive<S>(subscriber: S)
        where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            downstream.receive(subscriber: subscriber)
        }

    }
    
}

/// ...

public extension Publisher
where Self.Failure == Never, Self.Output == SignedInformation {

    /// ...
    
    func authenticateEach<A>(using authorIdentifier: A) -> Publishers.Authentic<Self, A>
    where A: AuthenticityIdentifier {
        return Publishers.Authentic(upstream: self, using: authorIdentifier)
    }

    /// ...
    
    func authenticateEach<A>(from author: A) -> Publishers.Authentic<Self, A.Identifier>
    where A: CryptoIdentity {
        return authenticateEach(using: author.publicIdentifier)
    }
    
}
