public protocol SecureStorage {
    func save<T: Codable>(key: String, value: T) throws
    func retrieve<T: Codable>(key: String) throws -> T?
    func delete(key: String) throws
}


