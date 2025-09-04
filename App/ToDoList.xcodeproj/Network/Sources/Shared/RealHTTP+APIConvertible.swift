import RealHTTP

public protocol APIResourceConvertible {
    associatedtype Result: Decodable // the output object of the service
    func request() -> HTTPRequest // function which generate a request
}

public extension HTTPClient {
    func fetch<T: APIResourceConvertible>(_ convertible: T) async throws -> T.Result {
        let result = try await convertible.request().fetch(self)
        return try result.decode(T.Result.self)
    }
}
