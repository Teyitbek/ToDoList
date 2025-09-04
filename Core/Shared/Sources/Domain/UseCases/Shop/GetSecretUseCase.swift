import Foundation

public protocol GetSecretUseCase {
    func execute() async throws -> Secret
}
