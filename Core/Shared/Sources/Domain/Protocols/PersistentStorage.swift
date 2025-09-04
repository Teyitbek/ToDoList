public protocol PersistentStorage {
    func save<T: Codable>(key: String, value: T) throws
    func retrieve<T: Codable>(key: String) throws -> T?
    func delete(key: String) throws
}

// StorageError.swift
public enum PersistentStorageError: Error {
    case saveFailure(String)
    case retrievalFailure(String)
    case deletionFailure(String)
}
