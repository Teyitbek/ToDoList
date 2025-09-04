import Foundation

public extension Decodable {
    init?(jsonData: Data) {
        guard let value = try? JSONDecoder().decode(Self.self, from: jsonData) else {
            return nil
        }
        
        self = value
    }
}
