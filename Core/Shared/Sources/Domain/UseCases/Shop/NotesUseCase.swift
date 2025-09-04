import Foundation

public protocol NotesUseCase {
    func execute(with notes: String) async throws -> (cart: Cart, message:  String?)
}
