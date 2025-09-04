import Foundation

public protocol GetLabelsUseCase {
    func execute(with languageCode: String) async throws -> [String: String]
}

public struct GetLabelsUseCaseImpl: GetLabelsUseCase {
    private let repository: LanguagesRemoteRepository
    
    public init(repository: LanguagesRemoteRepository) {
        self.repository = repository
    }
    
    public func execute(with languageCode: String) async throws -> [String : String] {
        try await repository.getLabels(for: languageCode)
    }
}
