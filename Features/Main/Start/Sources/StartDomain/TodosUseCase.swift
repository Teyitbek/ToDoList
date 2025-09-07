import Domain
import Foundation

public protocol TodosUseCase {
    func execute() async throws -> [TodoRepresentable]
}

