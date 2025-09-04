import Foundation

public protocol GetCartUseCase {
    func execute() async throws -> Cart
}
