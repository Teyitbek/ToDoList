import CollectionView
import Domain
//import Kingfisher
import UIKit

public class LanguageCVCell: CollectionViewCell<LanguageCVCellCV> {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        mainContentView.titleLabel.text = nil
        mainContentView.imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: LanguageRepresentable, selectedLanguage: LanguageRepresentable?) {
        mainContentView.titleLabel.text = model.title
//        mainContentView.imageView.kf.setImage(with: URL(string: model.icon))
        mainContentView.selected(model.id == selectedLanguage?.id)
    }
}
