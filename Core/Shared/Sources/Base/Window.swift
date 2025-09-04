import AppContainer
import UIKit

public final class Window: UIWindow {
    public override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)

        if event.allTouches?.contains(where: { $0.phase == .began }) == true {
            AppContainer.shared.inactivityTimerService().resetTimer()
        }
    }
}
