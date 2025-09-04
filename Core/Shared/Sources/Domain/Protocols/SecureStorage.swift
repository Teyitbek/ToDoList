public protocol SecureStorage {
    func save<T: Codable>(key: String, value: T) throws
    func retrieve<T: Codable>(key: String) throws -> T?
    func delete(key: String) throws
}

public enum KeychainError: Error {
    case invalidIdentifier
    case initializationFailure(String)
    case saveFailure(String)
    case retrievalFailure(String)
    case deletionFailure(String)
}


