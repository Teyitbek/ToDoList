import Domain
import Foundation

public protocol TodosRepository {
    func todos() async throws -> [TodoRepresentable]
}
