import XCTest
import Crypto

@testable import Identify
@testable import IdentificationProps
@testable import EllipticCurveIdentification

/// ...

final class Curve25519CryptoPerformanceTests: XCTestCase {

    typealias SubjectIdentity = EllipticCurveIdentification.Identity
    
    func testSpeedOfCreatingIdentity() {
        let sampleSize = 10000
        let iterations = 1...sampleSize
        
        measure {
            iterations.forEach { _ in
                _ = SubjectIdentity()
            }
        }
    }

    func testSpeedOfCalculatingPublicIdentifierFromIdentity() {
        let sampleSize = 10000
        let iterations = 1...sampleSize
        let identities = iterations.map { _ in return SubjectIdentity() }
        
        measure {
            identities.forEach {
                identity in _ = identity.publicIdentifier
            }
        }
    }
    
    func testSpeedOfSigningInformation() {
        let samples = samplesForSigning

        measure {
            samples.forEach { (author, message) in
                _ = try! author.signature(for: message)
            }
        }
    }
    

    func testSpeedOfVerifyingAuthorshipAuthenticity() {
        let samples = samplesForSigning.map { (author, message) in
            return (author, message, try! author.signature(for: message))
        }

        measure {
            samples.forEach { (author, message, signature) in
                _ = author.publicIdentifier.isAuthentic(signature, of: message)
            }
        }
    }

    /// Generate a batch of arbitrary identities and data.
    ///
    /// - Returns: A sequence of random curve25519 identities paired with an example content byte-string.
    ///
    
    private var samplesForSigning: [(SubjectIdentity, Data)] {
        var sampleSize = 9000000 // 9 megabytes
        let avgMessageSize = 25000 // XXX: Is that correct?
        let authorsCount = sampleSize / 25000
        let identities = (1...authorsCount).map { _ in return SubjectIdentity() }
        var samples = [(SubjectIdentity, Data)]()
        
        while sampleSize > 0 {
            let dev = avgMessageSize / 25
            let chunkSize = Int.random(in: (avgMessageSize-dev)...(avgMessageSize+dev))
            let chunkBytes = (1...chunkSize).map { _ in return UInt8.random(in: UInt8.min...UInt8.max) }

            sampleSize -= chunkSize

            samples.append((identities.randomElement()!, Data(chunkBytes)))
        }
        
        return samples
    }
    
}
