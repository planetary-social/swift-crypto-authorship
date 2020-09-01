import XCTest
import Crypto

@testable import Identify
@testable import IdentificationProps
@testable import EllipticCurveIdentification

final class Curve25519CryptoIdentityTests: XCTestCase {

    var props: UniversalProperties.EveryCryptographicIdentifier<EllipticCurveIdentification.Identity> {
        return .init(identifier: arbitraryIdentity, exactKeyByteCount: 32)
    }

    var arbitraryIdentity: EllipticCurveIdentification.Identity {
        return .init()
    }

    func testFixedLengthKeyConstraint() {
        XCTAssert(props.alwaysTheSameExactByteCount())
    }

    func testRequiredProtocolConformances() {
        XCTAssert(props.correctlyConformsToRawRepresentable())
        XCTAssert(props.correctlyConformsToHashable(against: arbitraryIdentity))
        XCTAssert(props.correctlyConformsToEquatable(against: arbitraryIdentity))
    }

}
