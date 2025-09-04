import Foundation

public protocol PayWithPointsUseCase {
    func execute() async throws -> String?
}
