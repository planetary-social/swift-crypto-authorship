/// ...

public enum AuthenticationError: Error, Equatable {
    
    /// ...
    
    case corruptedContentSignature
    
}

/// ...

public enum SigningError: Error {
    
    /// ...
    
    case signatureCalculationFailed(cause: Error)
    
}
