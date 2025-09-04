import Domain
import Foundation

public final class UserDefaultsService: PersistentStorage {
    private let defaults: UserDefaults

    /// Initializes the UserDefaultsService.
    /// - Parameter defaults: The UserDefaults instance to use (default: `.standard`).
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    /// Saves a value to UserDefaults.
    /// - Parameters:
    ///   - key: The key under which the value will be stored.
    ///   - value: The value to store (must conform to `Codable`).
    public func save<T: Codable>(key: String, value: T) throws {
        do {
            let encodedData = try JSONEncoder().encode(value)
            defaults.set(encodedData, forKey: key)
        } catch {
            throw PersistentStorageError.saveFailure("Failed to save value for key: \(key). Error: \(error)")
        }
    }

    /// Retrieves a value from UserDefaults.
    /// - Parameter key: The key under which the value is stored.
    /// - Returns: The retrieved value, or `nil` if not found or decoding fails.
    public func retrieve<T: Codable>(key: String) throws -> T? {
        guard let data = defaults.data(forKey: key) else {
            return nil
        }

        do {
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            return decodedValue
        } catch {
            throw PersistentStorageError.retrievalFailure("Failed to retrieve value for key: \(key). Error: \(error)")
        }
    }

    /// Deletes a value from UserDefaults.
    /// - Parameter key: The key under which the value is stored.
    public func delete(key: String) throws {
        defaults.removeObject(forKey: key)
    }
}
