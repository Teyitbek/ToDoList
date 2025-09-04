public protocol SaveLocationUseCase {
    func execute(with token: Locationable) throws
}

public struct SaveLocationUseCaseImpl: SaveLocationUseCase {
    private let repository: LocationRepository
    
    public init(repository: LocationRepository) {
        self.repository = repository
    }
    
    public func execute(with location: Locationable) throws {
        do {
            try repository.save(location: location)
        } catch {
            throw error
        }
    }
}
