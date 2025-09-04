import Foundation
import Domain

public protocol GetBannersUseCase {
    func execute() async throws -> [any BannerRepresentable]
}
