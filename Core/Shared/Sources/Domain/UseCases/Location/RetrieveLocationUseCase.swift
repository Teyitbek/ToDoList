public protocol RetrieveLocationUseCase {
    func execute() throws -> Locationable?
}

public struct RetrieveLocationUseCaseImpl: RetrieveLocationUseCase {
    private let repository: LocationRepository
    
    public init(repository: LocationRepository) {
        self.repository = repository
    }
    
    public func execute() throws -> Locationable? {
        do {
            return try repository.getLocation()
        } catch {
            throw error
        }
    }
}
