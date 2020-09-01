import XCTest
import Crypto

@testable import Identify
@testable import IdentificationProps
@testable import EllipticCurveIdentification

final class Curve25519AuthenticityIdentifierTests: XCTestCase {

    var props: UniversalProperties.EveryCryptographicIdentifier<EllipticCurveIdentification.PublicIdentifier> {
        return .init(identifier: arbitraryPublicIdentifier, exactKeyByteCount: 32)
    }

    var arbitraryIdentity: EllipticCurveIdentification.Identity {
        return .init()
    }

    var arbitraryPublicIdentifier: EllipticCurveIdentification.PublicIdentifier {
        return arbitraryIdentity.publicIdentifier
    }

    func testFixedLengthKeyConstraint() {
        XCTAssert(props.alwaysTheSameExactByteCount())
    }

    func testRequiredProtocolConformances() {
        let otherIdentifier = EllipticCurveIdentification.Identity().publicIdentifier

        XCTAssert(props.correctlyConformsToRawRepresentable())
        XCTAssert(props.correctlyConformsToHashable(against: arbitraryPublicIdentifier))
        XCTAssert(props.correctlyConformsToEquatable(against: arbitraryPublicIdentifier))
    }

}
