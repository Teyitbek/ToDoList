import Foundation

public struct GetOrderItemUseCaseImpl: GetOrderItemDetailsUseCase {
    private let repository: OrderRepository
    
    public init(repository: OrderRepository) {
        self.repository = repository
    }
    
    public func execute(with id: Int) async throws -> ProductDetails {
        try await repository.getOrderItemDetails(with: id)
    }
}
