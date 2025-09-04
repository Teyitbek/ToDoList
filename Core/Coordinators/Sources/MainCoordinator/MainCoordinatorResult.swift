import Coordinator
import UIKit
import Domain
import Base

public protocol MainCoordinatorResult: CoordinatorResult {
    var finishFlow: (() -> Void)? { get set }
    var orderFlow: (() -> Void)? { get set }
}
