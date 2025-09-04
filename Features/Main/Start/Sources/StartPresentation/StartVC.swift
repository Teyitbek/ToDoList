import ActivityIndicator
import CollectionView
import Constants
import Combine
import Domain
import MessageView
import UIKit
import Fonts
import Base
import LocalizationManager

public final class StartVC: ViewController<StartCV, StartVM> {
    private var bannerTimer: Timer?
    private var currentBannerIndex = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presentActivity()
        viewModel.getData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.sessionService.accessTokenIsAvailable {
            viewModel.socketService.connect()
        }
    }
    
    public override func bindCV() {
        super.bindCV()
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        
        contentView.startButton.addTarget(self, action: #selector(onStartAction), for: .touchUpInside)
    }
    
    public override func localize(with labels: [String : String]) {
        contentView.startButton.setTitle(labels[L10n.Actions.touchToStart] ?? "Touch to Start", for: .normal)
    }
    
    public override func bindVM() {
        super.bindVM()
        viewModel.languagesSubject
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] languages in
                guard let self = self else { return }
                self.contentView.collectionView.reloadData()
                self.dismissActivity()
            }
            .store(in: &cancellables)
        
        viewModel.bannersSubject
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] banners in
                guard let self = self else { return }
                self.currentBannerIndex = 0
                self.updateBannerImage()
                self.startBannerTimer()
            }
            .store(in: &cancellables)
        
        viewModel.errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.dismissActivity()
            }
            .store(in: &cancellables)
    }
    
    private func startBannerTimer() {
        bannerTimer?.invalidate()
        bannerTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.showNextBanner()
            }
        }
    }

    @MainActor
    private func showNextBanner() {
        guard !viewModel.bannersSubject.value.isEmpty else { return }
        currentBannerIndex = (currentBannerIndex + 1) % viewModel.bannersSubject.value.count
        updateBannerImage()
    }

    @MainActor
    private func updateBannerImage() {
        let banner = viewModel.bannersSubject.value[safe: currentBannerIndex]
        contentView.imageView.kf.setImage(with: URL(string: banner?.path ?? ""), placeholder: UIImage.backgroundMain)
    }
}

@objc
private extension StartVC {
    func onStartAction() {
        viewModel.saveSelectedLanguage()
    }
}
extension StartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.languagesSubject.value.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LanguageCVCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(with: viewModel.languagesSubject.value[indexPath.row], selectedLanguage: viewModel.selectedLanguage)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItemCentered(at: indexPath, animated: true)
        viewModel.selectedLanguage = viewModel.languagesSubject.value[indexPath.row]
        viewModel.getLabels(onStart: false)
        presentActivity()
        collectionView.reloadData()
    }
    
    private func scrollToItemCentered(at indexPath: IndexPath, animated: Bool) {
        guard let layout = contentView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
              let attributes = layout.layoutAttributesForItem(at: indexPath) else { return }
        let itemFrame = attributes.frame
        let collectionWidth = contentView.collectionView.bounds.width
        let offSetX = itemFrame.midX - collectionWidth / 2
        let maxOffsetX = contentView.collectionView.contentSize.width - collectionWidth
        let targetOffsetX = max(0, min(offSetX, maxOffsetX))
        contentView.collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: animated)
    }
}
extension StartVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = viewModel.languagesSubject.value[indexPath.row].title.size(withAttributes: [.font: Fonts.murecho.font(forTextStyle: .title2)])
        return CGSize(width: width.width + Constants.Constraints.WidthBased._100, height: Constants.Constraints.HeightBased._68)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let itemCount = collectionView.numberOfItems(inSection: section)
        guard itemCount > 0 else { return .zero }
        let itemSize = layout.itemSize
        let itemSpacing = layout.minimumLineSpacing
        
        let totalItemWidth = CGFloat(itemCount) * itemSize.width
        let totalSpacingWidth = CGFloat(itemCount - 1) * itemSpacing
        
        let totalContentWidth = totalItemWidth + totalSpacingWidth
        let collectionViewWidth = collectionView.bounds.width
        
        let inset = max((collectionViewWidth - totalContentWidth) / 2, 0)
        
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}

