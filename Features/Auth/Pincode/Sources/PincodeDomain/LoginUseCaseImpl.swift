import Domain

public protocol LoginUseCase {
    func execute(with credentials: Pincodeable) async throws -> UserInfoRepresentable
}

public final class LoginUseCaseImpl: LoginUseCase {
    private let repository: LoginRepository
    
    public init(repository: LoginRepository) {
        self.repository = repository
    }
    
    public func execute(with credentials: Pincodeable) async throws -> UserInfoRepresentable {
        try await repository.login(with: credentials)
    }
}
