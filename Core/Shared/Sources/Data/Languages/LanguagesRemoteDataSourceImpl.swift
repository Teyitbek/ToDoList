import Domain
import RealHTTP

public protocol LanguagesRemoteDataSource {
    func getLanguages() async throws -> [LanguageRepresentable]
    func getLabels(for language: String) async throws -> [String: String]
}

public struct LanguagesRemoteDataSourceImpl: LanguagesRemoteDataSource {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getLanguages() async throws -> [LanguageRepresentable] {
        try await client.fetch(LanguagesRequestDTO()).data.map { $0.toDomain() }
    }
    
    public func getLabels(for language: String) async throws -> [String : String] {
        try await client.fetch(GetLabelsRequestDTO(language: language)).data
    }
}
