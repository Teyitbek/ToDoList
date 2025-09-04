import Foundation

public struct PostOrderItemUseCaseImpl: PostOrderItemDetailsUseCase {
    private let repository: OrderRepository
    
    public init(repository: OrderRepository) {
        self.repository = repository
    }
    
    public func execute(with id: Int, details: CartProduct) async throws -> Cart {
        try await repository.postOrderItemDetails(with: id, details: details)
    }
}
