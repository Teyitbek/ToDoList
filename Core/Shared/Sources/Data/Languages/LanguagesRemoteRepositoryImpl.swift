import Domain

public struct LanguagesRemoteRepositoryImpl: LanguagesRemoteRepository {
    private let remoteDataSource: LanguagesRemoteDataSource
    
    public init(remoteDataSource: LanguagesRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getLanguages() async throws -> [any Domain.LanguageRepresentable] {
        try await remoteDataSource.getLanguages()
    }
    
    public func getLabels(for language: String) async throws -> [String : String] {
        try await remoteDataSource.getLabels(for: language)
    }
}
