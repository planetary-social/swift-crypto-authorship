# Cryptographic Authorship in Swift

- TODO: Abstract.
- TODO: Example usage (or reference to examples).

## Getting Started


```swift
import Foundation
import Identify
import EllipticCurveIdentification
```

```swift
let queen = EllipticCurveIdentification.Identity()
let rhapsody = "Scaramouche, will you do the Fandango?".data(using: .utf8)
let rhapsodyProof = try! AuthenticityProof(of: rhapsody, from: queen)
```

```swift
AuthenticityProof(of: rhapsody, 
                  verifying: rhapsodyProof.signature, 
                  using: queen.publicIdentifier) 
// => AutnenticityProof(content:signature:)
```

```swift
let pinkFloyd = EllipticCurveIdentification.Identity()
let brainDamage = "I'll see you on the dark side of the Moon.".data(using: .utf8)
let brainDamageProof = try! AuthenticityProof(of: brainDamage, from: pinkFloyd)
```

```swift
AuthenticityProof(of: braninDamage, 
                  verifying:  brainDamageProof.signature, 
                  using: queen.publicIdentifier) 
// => nil
```

```swift
AuthenticityProof(of: braninDamage, 
                  verifying:  rhapsodyProof.signature, 
                  using: queen.publicIdentifier) 
// => nil
```

```swift
AuthenticityProof(of: brainDamage,
                  verifying: brainDamageProof.signature
                  using: pinkFloyd.publicIdentifier) 
// => AutnenticityProof(content:signature:)
```
