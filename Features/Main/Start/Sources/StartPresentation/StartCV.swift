import Constants
import Extensions
import Fonts
import UIKit
import TableView
import Base

public class StartCV: ContentView {
    public lazy var tableView = makeTableView()
    public lazy var bottomView = makeBottomView()
    
    private let bottomViewHeight: CGFloat = Constants.UI.padding84
        
    init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSubviews() {
        addSubview(tableView)
        addSubview(bottomView)
    }
    
    public override func setConstraints() {
        tableView.fillSuperview()
        
        bottomView.anchor(
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .bottom(bottomAnchor),
            .height(bottomViewHeight)
        )
    }
    
    public func setProperties() {
        backgroundColor = .black
    }
}
private extension StartCV {
    func makeTableView() -> TableView {
        let tableView = TableView(style: .plain, cells: [NoteTVCell.self], contentInset: .init(top: 0, left: 0, bottom: bottomViewHeight, right: 0))
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }
    
    func makeBottomView() -> TaskBottomView {
        let view = TaskBottomView()
        view.addNewNoteButton.setImage(.editNote.withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }
}
