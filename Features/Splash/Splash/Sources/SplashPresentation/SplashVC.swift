import ActivityIndicator
import MessageView
import UIKit
import Base

public final class SplashVC: ViewController<SplashCV, SplashVM> {
    override public func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
        viewModel.checksAndFetchRequiredData()
    }
    
    public override func bindVM() {
        super.bindVM()
        viewModel.indexResultSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] token in
                guard let self else { return }
                self.dismissActivity()
            }
            .store(in: &viewModel.cancellables)
    }
    
    public override func bindCV() {
        super.bindCV()
    }
}
