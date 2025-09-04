import UIKit

class ActivityIndicatorOverlayView: UIView {
    private lazy var contentView = makeContentView()
    private lazy var spinner = makeSpinner()
    private var shouldShowLoader = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.setupUI()
        self.setConstraints()
    }
}

extension ActivityIndicatorOverlayView {
    func show() {
        shouldShowLoader = true
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if self.shouldShowLoader {
                self.isHidden = false
            }
        }
    }
    
    func hide() {
        shouldShowLoader = false
        self.isHidden = true
    }
}

extension ActivityIndicatorOverlayView {
    private func setupUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.layer.zPosition = 1
        self.isHidden = true
        self.addSubview(contentView)
        contentView.addSubview(spinner)
    }
    
    private func setConstraints() {
        spinner.anchor(
            .centerX(contentView.centerXAnchor),
            .centerY(contentView.centerYAnchor),
            .height(50),
            .width(50)
        )
        
        contentView.anchor(
            .centerX(self.centerXAnchor),
            .centerY(self.centerYAnchor),
            .height(70),
            .width(70)
        )
    }
}

private extension ActivityIndicatorOverlayView {
    func makeContentView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.roundSpecificCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 15)
        return view
    }
    
    func makeSpinner() -> ActivityIndicatorView {
        let spinner = ActivityIndicatorView()
        spinner.animating = true
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }
}
