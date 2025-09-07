import Domain
import Data
import Foundation

public protocol DeleteTodoUseCase {
    func execute(with id: Int) async throws -> DeleteTodoResponse
}

