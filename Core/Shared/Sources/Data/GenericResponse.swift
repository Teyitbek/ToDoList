import Foundation

public protocol DomainMappable {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}

public struct GenericResponse<T: Decodable>: Decodable {
    public var data: T
    public var message: String?
    
    public init(data: T, message: String) {
        self.data = data
        self.message = message
    }
}

extension GenericResponse where T: DomainMappable {
    public func toDomain() -> T.DomainModel {
        return data.toDomain()
    }
}
