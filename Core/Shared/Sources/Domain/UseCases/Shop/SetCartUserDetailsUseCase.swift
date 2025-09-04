import Foundation

public protocol SetCartUserDetailsUseCase {
    func execute(userDetails: CartUserDetails) async throws -> Cart
}
