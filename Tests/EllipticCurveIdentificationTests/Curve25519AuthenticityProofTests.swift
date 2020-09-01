import XCTest
import Crypto

@testable import Identify
@testable import IdentificationProps
@testable import EllipticCurveIdentification

final class Curve25519AuthenticityProofTests: XCTestCase {

    var props: UniversalProperties.EveryAuthenticityProof<EllipticCurveIdentification.Identity> {
        return .init(author: arbitraryIdentity(), exampleContent: randomContent())
    }

    private func arbitraryIdentity() -> EllipticCurveIdentification.Identity {
        return .init()
    }

    private func randomContent() -> Data {
        return Data((0...randomContentLength).map { _ in UInt8.random(in: 0...255) })
    }

    private let randomContentLength = Int.random(in: 0...4086)

    func testCorrectGeneration() {
        XCTAssert(props.generatesCorrectly())
    }

    func testValidScenarios() {
        XCTAssert(props.validWithTheSameAuthorAndContent())
    }

    func testFailures() {
        XCTAssert(props.invalidWithDifferentContent(anotherContent: randomContent()))
        XCTAssert(props.invalidWithSomeoneElseThanAuthor(forger: arbitraryIdentity()))
    }

}
