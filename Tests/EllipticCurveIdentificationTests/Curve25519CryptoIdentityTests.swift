import XCTest
import Crypto

@testable import Identify
@testable import IdentificationProps
@testable import EllipticCurveIdentification

final class Curve25519CryptoIdentityTests: XCTestCase {

    var props: UniversalProperties.EveryCryptographicIdentifier<EllipticCurveIdentification.Identity> {
        return .init(identifier: subjectIdentity, exactKeyByteCount: 32)
    }

    var subjectIdentity: EllipticCurveIdentification.Identity {
        return .init()
    }
        
    func testFixedLengthKeyConstraint() {
        XCTAssert(props.alwaysTheSameExactByteCount())
    }

    func testConformanceToRawRepresentable() {
        XCTAssert(props.correctlyConformsToRawRepresentable())
    }

}
