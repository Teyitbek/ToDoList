import Foundation

public protocol SaveLabelsUseCase {
    func execute(_ labels: [String:String]) throws
}

public struct SaveLabelsUseCaseImpl: SaveLabelsUseCase {
    private let repository: LanguagesLocalRepository
    
    public init(repository: LanguagesLocalRepository) {
        self.repository = repository
    }
    
    public func execute(_ labels: [String:String]) throws {
        try repository.save(labels: labels)
    }
}
