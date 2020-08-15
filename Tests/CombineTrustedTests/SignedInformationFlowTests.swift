import XCTest
import Combine
import Identify
import EllipticCurveIdentification

@testable import CombineTrusted

final class SignedInformationFlowTests: XCTestCase {
    
    var sampleCryptoIdentity: EllipticCurveIdentification.Identity { .init() }

    var sampleData: Data { .init((0...sampleDataLength).map { _ in randomByte }) }

    var sampleDataLength: Int { Int.random(in: (2048...4096)) }

    var randomByte: UInt8 { UInt8.random(in: 0...255) }

    func testSuccessfulCombining() {
        let expectedOutput = expectation(description: "expected to reach the final output")

        let author = sampleCryptoIdentity
        let sample = sampleData
        
        let subscription =
            CurrentValueSubject<Data, Never>(sample)
            .signEach(as: author)
            .assertNoFailure()
            .map { proof in (content: proof.content, signature: proof.signature) }
            .authenticateEach(from: author)
            .assertNoFailure()
            .sink { output in
                XCTAssertEqual(sample, output)
                expectedOutput.fulfill()
            }

        waitForExpectations(timeout: 5, handler: nil)
        
        subscription.cancel()
    }
    
    func testFailedSigning() {
        let expectedFailure = expectation(description: "expected signing to fail")

        let author = try! Fakes.IdentityWithAlwaysFailingSignature()
        let sample = sampleData
                
        let subscription =
            CurrentValueSubject<Data, Never>(sample)
            .signEach(as: author)
            .catch { (error: SigningError) -> Empty<AuthenticityProof, Never> in
                expectedFailure.fulfill()
                return Empty(completeImmediately: true)
            }
            .assertNoFailure()
            .sink { _ in }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        subscription.cancel()
    }
    
    func testFailedAuthentication() {
        let expectedFailure = expectation(description: "expected authentication to fail")

        let author = sampleCryptoIdentity
        let forger = sampleCryptoIdentity
        let sample = sampleData

        let subscription =
            CurrentValueSubject<Data, Never>(sample)
            .signEach(as: author)
            .assertNoFailure()
            .map { proof in (content: proof.content, signature: proof.signature) }
            .authenticateEach(from: forger)
            .catch { (error: AuthenticationError) -> Empty<Data, Never> in
                XCTAssertEqual(error, .corruptedContentSignature)
                expectedFailure.fulfill()
                return Empty(completeImmediately: true)
            }
            .assertNoFailure()
            .sink { _ in }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        subscription.cancel()
    }
    
}
