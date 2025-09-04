import Foundation

extension Array {
    public func decode<T: Decodable>(_ decodable: T.Type, decoder: JSONDecoder = .init()) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: self)
        let decodedObj = try decoder.decode(T.self, from: data)
        return decodedObj
    }
}
