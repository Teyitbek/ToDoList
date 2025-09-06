import Domain
import Foundation

public typealias UseCases = ()

public final class SessionService: SessionManaging {
    private let useCases: UseCases
    
    public init(useCases: UseCases) {
        self.useCases = useCases
    }
}
