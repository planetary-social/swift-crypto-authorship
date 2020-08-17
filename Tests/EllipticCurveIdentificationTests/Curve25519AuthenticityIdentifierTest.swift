import XCTest
import Crypto

@testable import Identify
@testable import IdentificationProps
@testable import EllipticCurveIdentification

final class Curve25519AuthenticityIdentifierTests: XCTestCase {

    var props: UniversalProperties.EveryCryptographicIdentifier<EllipticCurveIdentification.PublicIdentifier> {
        return .init(identifier: subjectPublicIdentifier, exactKeyByteCount: 32)
    }
    
    var subjectIdentity: EllipticCurveIdentification.Identity {
        return .init()
    }

    var subjectPublicIdentifier: EllipticCurveIdentification.PublicIdentifier {
        return subjectIdentity.publicIdentifier
    }
        
    func testFixedLengthKeyConstraint() {
        XCTAssert(props.alwaysTheSameExactByteCount())
    }

    func testConformanceToRawRepresentable() {
        XCTAssert(props.correctlyConformsToRawRepresentable())
    }

}
