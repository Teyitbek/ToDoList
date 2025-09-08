import ActivityIndicator
import Constants
import Combine
import Domain
import UIKit
import Fonts
import Base

public final class StartVC: ViewController<StartCV, StartVM> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presentActivity()
        viewModel.getData()
        setupSearchController()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    public override func bindCV() {
        super.bindCV()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        contentView.bottomView.addNewNoteButton.addTarget(self, action: #selector(onAddNewNoteAction), for: .touchUpInside)
    }
    
    public override func bindVM() {
        super.bindVM()
        viewModel.errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.dismissActivity()
            }
            .store(in: &cancellables)
        
        viewModel.todosSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.dismissActivity()
                self.viewModel.initialTodoModel = model
                self.viewModel.todoModel = model
                self.contentView.bottomView.notestLabel.text = "\(viewModel.initialTodoModel.count) notes"
                self.contentView.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.deleteSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] todo in
                guard let self = self else { return }
                self.dismissActivity()
                guard todo.isDeleted else { return }
                self.viewModel.initialTodoModel.removeAll { $0.id == todo.id }
                self.viewModel.todoModel.removeAll { $0.id == todo.id }
                self.viewModel.coreDataManager.model.removeAll { $0.id == todo.id }
                self.contentView.bottomView.notestLabel.text = "\(viewModel.initialTodoModel.count) notes"
                self.contentView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

@objc
private extension StartVC {
    func onAddNewNoteAction() {
        viewModel.onDetailsAction?(nil)
    }
}
extension StartVC: UISearchControllerDelegate, UISearchBarDelegate {
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search"
        search.searchBar.tintColor = .white
        search.searchBar.barStyle = .black
        search.searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(0.1)
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.isSearchingMode = true
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearchingMode = false
        viewModel.todoModel = viewModel.initialTodoModel
        contentView.tableView.reloadData()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.todoModel = []
        for item in viewModel.initialTodoModel {
            if item.todo.lowercased().contains(searchText.lowercased()) {
                viewModel.todoModel.append(item)
            }
        }
        if searchText.isEmpty {
            viewModel.todoModel = viewModel.initialTodoModel
        }
        contentView.tableView.reloadData()
    }
}

extension StartVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.todoModel.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteTVCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(with: viewModel.todoModel[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onDetailsAction?(viewModel.todoModel[indexPath.row])
    }
    
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let todo = viewModel.todoModel[indexPath.row]
        return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: {
            return PreviewVC(model: todo)
        }, actionProvider: { _ in
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { _ in
                print("Edit tapped")
            }
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("Share tapped")
            }
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.viewModel.deleteTodo(with: todo.id)
            }
            return UIMenu(title: "", children: [edit, share, delete])
        })
    }
    
    public func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let indexPath = configuration.identifier as? IndexPath, let cell = tableView.cellForRow(at: indexPath) else { return nil }
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        return UITargetedPreview(view: cell.contentView, parameters: parameters)
    }
    
    public func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let indexPath = configuration.identifier as? IndexPath, let cell = tableView.cellForRow(at: indexPath) else { return nil }
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        return UITargetedPreview(view: cell.contentView, parameters: parameters)
    }
}

extension StartVC: NoteTVCellDelegate {
    func didTap(_ cell: NoteTVCell) {
        guard let indexPath = contentView.tableView.indexPath(for: cell) else { return }
        viewModel.todoModel[indexPath.row].completed.toggle()
        contentView.tableView.reloadData()
    }
}

private class PreviewVC: UIViewController {
    var model: TodoRepresentable
    
    init(model: TodoRepresentable) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let contentView = PreviewCV()
        contentView.titleLabel.text = model.todo
        contentView.subtitleLabel.text = model.completed ? "Completed" : "Not Completed"
        contentView.dateLabel.text = model.completed ? "2021-07-28" : "2021-07-27"
        view = contentView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
