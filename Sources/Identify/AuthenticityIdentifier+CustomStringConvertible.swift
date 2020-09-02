public extension AuthenticityIdentifier {

    public var description: String {
        return rawValue.base64EncodedString()
    }

}
