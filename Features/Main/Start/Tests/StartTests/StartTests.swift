import XCTest
import Combine
@testable import Start

final class StartTests: XCTestCase {
    // MARK: - VM
    var viewModel: StartVM!
    var vc: StartVC!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        let mockCoreData = TestCoreDataManager()
        let mockUseCases = (
            getTodos: MockGetTodosUseCase(),
            deleteTodo: MockDeleteTodoUseCase()
        )
        viewModel = StartVM(coreDataManager: mockCoreData, sessionService: MockSessionService(), useCases: mockUseCases)
    }
    
    func testGetLocalDataLoadsTodosAndEmits() {
        let expectation = XCTestExpectation(description: "todosSubject emits")
        
        viewModel.coreDataManager.add(Todo(todo: "Local note", id: 0, completed: false, userId: 1, uuid: UUID()))
        
        viewModel.todosSubject
            .sink { todos in
                XCTAssertEqual(todos.count, 1)
                XCTAssertEqual(todos.first?.todo, "Local note")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getLocalData()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetRemoteDataMergesAndEmitsTodos() async {
        let expectation = XCTestExpectation(description: "todosSubject emits merged data")
        
        viewModel.coreDataManager.add(Todo(todo: "Local unsynced", id: 0, completed: false, userId: 1, uuid: UUID()))
        
        viewModel.todosSubject
            .sink { todos in
                XCTAssertEqual(todos.count, 2)
                XCTAssertTrue(todos.contains { $0.todo == "Local unsynced" })
                XCTAssertTrue(todos.contains { $0.todo == "Remote note" })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.getRemoteData()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDeleteLocalTodoRemovesAndEmits() {
        let expectation = XCTestExpectation(description: "deleteSubject emits true")
        
        let uuid = UUID()
        viewModel.coreDataManager.add(Todo(todo: "To delete", id: 0, completed: false, userId: 1, uuid: uuid))
        
        viewModel.deleteSubject
            .sink { success in
                XCTAssertTrue(success)
                XCTAssertEqual(self.viewModel.todos.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.delete(todo: Todo(todo: "To delete", id: 0, completed: false, userId: 1, uuid: uuid))
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDeleteRemoteTodoRemovesAndEmits() async {
        let expectation = XCTestExpectation(description: "deleteSubject emits true")
        
        let remoteTodo = Todo(todo: "Remote to delete", id: 1, completed: false, userId: 1)
        viewModel.coreDataManager.add(remoteTodo)
        
        viewModel.deleteSubject
            .sink { success in
                XCTAssertTrue(success)
                XCTAssertEqual(self.viewModel.todos.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.delete(todo: remoteTodo)
        wait(for: [expectation], timeout: 1.0)
    }
    
    final class FailingDeleteTodoUseCase: DeleteTodoUseCase {
        func execute(with id: Int) async throws -> Todo {
            throw NSError(domain: "TestError", code: 999, userInfo: nil)
        }
    }
    
    func testDeleteTodoEmitsErrorOnFailure() async {
        let expectation = XCTestExpectation(description: "errorSubject emits")
        
        viewModel = StartVM(
            coreDataManager: TestCoreDataManager(),
            sessionService: MockSessionService(),
            useCases: (
                getTodos: MockGetTodosUseCase(),
                deleteTodo: FailingDeleteTodoUseCase()
            )
        )
        
        viewModel.errorSubject
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.delete(todo: Todo(todo: "Failing", id: 1, completed: false, userId: 1))
        wait(for: [expectation], timeout: 1.0)
    }
    // MARK: - VC
    func testTodosSubjectUpdatesTableViewAndLabel() {
        let mockVM = StartVM(coreDataManager: TestCoreDataManager(), sessionService: MockSessionService(), useCases: (MockGetTodosUseCase(), MockDeleteTodoUseCase()))
        vc.viewModel = mockVM
        
        _ = vc.view
        vc.bindVM()
        
        mockVM.todosSubject.send([
            Todo(todo: "Test note", id: 1, completed: false, userId: 1)
        ])
        
        XCTAssertEqual(vc.contentView.bottomView.notestLabel.text, "1 notes")
        XCTAssertEqual(vc.contentView.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testSearchBarFiltersNotes() {
        let vc = StartVC()
        let mockVM = StartVM(coreDataManager: TestCoreDataManager(), sessionService: MockSessionService(), useCases: (MockGetTodosUseCase(), MockDeleteTodoUseCase()))
        vc.viewModel = mockVM
        
        mockVM.todos = [
            Todo(todo: "Buy milk", id: 1, completed: false, userId: 1),
            Todo(todo: "Call mom", id: 2, completed: false, userId: 1)
        ]
        mockVM.initialTodos = mockVM.todos
        
        vc.searchBar(UISearchBar(), textDidChange: "milk")
        
        XCTAssertEqual(mockVM.todos.count, 1)
        XCTAssertEqual(mockVM.todos.first?.todo, "Buy milk")
    }
}

final class MockGetTodosUseCase: TodosUseCase {
    func execute() async throws -> [Todo] {
        return [Todo(todo: "Remote note", id: 1, completed: false, userId: 1)]
    }
}

final class MockDeleteTodoUseCase: DeleteTodoUseCase {
    func execute(with id: Int) async throws -> Todo {
        return Todo(todo: "Deleted", id: id, completed: false, userId: 1)
    }
}

final class MockSessionService: SessionManaging {}
