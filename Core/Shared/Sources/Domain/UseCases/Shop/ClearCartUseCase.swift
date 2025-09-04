import Foundation

public protocol ClearCartUseCase {
    func execute() async throws -> Cart
}
