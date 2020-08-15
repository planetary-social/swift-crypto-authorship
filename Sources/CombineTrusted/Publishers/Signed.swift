import Foundation
import Identify
import Combine

// MARK: Combine Freshly Signed Information

public extension Publishers {

    /// ...
    
    struct Signed<Upstream, AuthorIdentity>: Publisher
    where Upstream: Publisher, Upstream.Failure == Never, Upstream.Output == Data,
          AuthorIdentity: CryptoIdentity {

        public typealias Failure = SigningError
        public typealias Output = AuthenticityProof

        /// ...
        
        public let upstream: Upstream
        
        /// ...
        
        public let author: AuthorIdentity

        /// ...
        
        private let downstream: AnyPublisher<Output, Failure>
        
        /// ...
        
        public init(upstream: Upstream, from author: AuthorIdentity) {
            self.upstream = upstream
            self.author = author

            // Map each message from the upstream to an authenticity proof from current author:
            self.downstream =
                upstream
                .tryMap { data in try AuthenticityProof(of: data, from: author) }
                .mapError(Failure.signatureCalculationFailed(cause:))
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
where Self.Failure == Never, Self.Output == Data {

    /// ...
    
    func signEach<A>(as author: A) -> Publishers.Signed<Self, A>
    where A: CryptoIdentity {
        return Publishers.Signed(upstream: self, from: author)
    }
    
}
