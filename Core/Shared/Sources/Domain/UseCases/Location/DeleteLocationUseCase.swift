public protocol DeleteLocationUseCase {
    func execute() throws
}

public struct DeleteLocationUseCaseImpl: DeleteLocationUseCase {
    private let repository: LocationRepository
    
    public init(repository: LocationRepository) {
        self.repository = repository
    }
    
    public func execute() throws {
        do {
            return try repository.deleteLocation()
        } catch {
            throw error
        }
    }
}
