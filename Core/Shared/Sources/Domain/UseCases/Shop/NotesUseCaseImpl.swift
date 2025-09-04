public struct NotesUseCaseImpl: NotesUseCase {
    private let repository: ShopRepository
    
    public init(repository: ShopRepository) {
        self.repository = repository
    }
    
    public func execute(with notes: String) async throws -> (cart: Cart, message:  String?) {
        try await repository.setNotes(with: notes)
    }
}
