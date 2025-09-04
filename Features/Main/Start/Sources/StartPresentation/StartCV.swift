import CollectionView
import Constants
import Extensions
import Fonts
import UIKit
import SwiftUI
import TableView
import TextField
//import FFNavigationBar
import Base

public protocol StartContentView: UIView {
    var imageView: UIImageView { get }
    var collectionView: CollectionView { get }
    var startButton: UIButton { get }
}

public class StartCV: ContentView, StartContentView {
    private let gradientLayer = CAGradientLayer()
    public lazy var imageView = makeMainImageView()
    public lazy var collectionView = makeCollectionView()
    public lazy var startButton = makeStartButton()
        
    init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        applyEdgeFadeMask()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSubviews() {
        addSubview(imageView)
        addSubview(collectionView)
        addSubview(startButton)
    }
    
    public override func setConstraints() {
        imageView.fillSuperview()
        
        collectionView.anchor(
            .leading(startButton.leadingAnchor),
            .trailing(startButton.trailingAnchor),
            .bottom(startButton.topAnchor, constant: Constants.Constraints.HeightBased._40),
            .height(Constants.Constraints.HeightBased._68)
        )
        
        startButton.anchor(
            .leading(leadingAnchor, constant: Constants.Constraints.WidthBased._60),
            .trailing(trailingAnchor, constant: Constants.Constraints.WidthBased._60),
            .bottom(bottomAnchor, constant: Constants.Constraints.WidthBased._40),
            .height(Constants.Constraints.HeightBased._112)
        )
    }
    
    public func setProperties() {
        backgroundColor = .clear
    }
    
    private func applyEdgeFadeMask() {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = collectionView.bounds
        maskLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        maskLayer.locations = [0.0, 0.1, 0.9, 1.0]
        maskLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        maskLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        collectionView.layer.mask = maskLayer
    }
}
private extension StartCV {
    func makeMainImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .backgroundMain
        return imageView
    }
    
    func makeCollectionView() -> CollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.Constraints.WidthBased._16
        layout.minimumLineSpacing = Constants.Constraints.WidthBased._16
        let collectionView = CollectionView(collectionViewLayout: layout, scrollDirection: .horizontal, cells: [LanguageCVCell.self])
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    func makeStartButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(.FFFFFF, for: .normal)
        button.titleLabel?.font = Fonts.murecho.font(forTextStyle: .title2)
        button.backgroundColor = ._31974_A
        button.cornerRadius = Constants.Constraints.HeightBased._16
        return button
    }
}
