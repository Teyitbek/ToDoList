import Foundation

public protocol GetAppInitUseCase {
    func execute() async throws -> AppInit
}
