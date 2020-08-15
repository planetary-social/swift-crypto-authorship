/// ...

public enum SigningError: Error {
    
    /// ...
    
    case signatureCalculationFailed(cause: Error)
    
}
