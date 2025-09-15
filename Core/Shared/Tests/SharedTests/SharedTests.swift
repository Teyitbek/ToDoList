// swiftlint:disable all

import XCTest
@testable import Shared

final class TestCoreDataManager: CoreDataManager {
    override init() {
        super.init()
        // Configure in-memory store for testing
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
    }
}

final class SharedTests: XCTestCase {
    var manager: CoreDataManager!

    override func setUp() {
        super.setUp()
        manager = TestCoreDataManager()
    }

    func testAddTodoModelStoresAndFetchesCorrectly() {
        // Given
        let todo = Todo(todo: "Test note", id: 1, completed: false, userId: 42, uuid: UUID())
        // When
        manager.add(todo)
        // Then
        XCTAssertEqual(manager.todoData.count, 1)
        XCTAssertEqual(manager.todoData.first?.todo, "Test note")
        XCTAssertEqual(manager.todoData.first?.userId, 42)
        XCTAssertFalse(manager.todoData.first?.completed ?? true)
    }
    
    func testDeleteAllModelsClearsStore() {
        let todo = Todo(todo: "To delete", id: 2, completed: true, userId: 99, uuid: UUID())
        manager.add(todo)

        XCTAssertEqual(manager.todoData.count, 1)

        manager.deleteAllModels()
        XCTAssertEqual(manager.todoData.count, 0)
    }

    func testFetchAllModelSortsByCreatedAtDescending() {
        let first = Todo(todo: "First", id: 1, completed: false, userId: 1, uuid: UUID())
        let second = Todo(todo: "Second", id: 2, completed: false, userId: 1, uuid: UUID())

        manager.add(first)
        sleep(1)
        manager.add(second)

        XCTAssertEqual(manager.todoData.first?.todo, "Second")
    }

    func testAddAssignsUUIDToNewModel() {
        let todo = Todo(todo: "UUID test", id: 3, completed: false, userId: 1, uuid: nil)
        manager.add(todo)

        XCTAssertNotNil(manager.todoData.first?.uuid)
    }
    
    func testAddTodoWithNilText() {
        let todo = Todo(todo: nil, id: 4, completed: false, userId: 1, uuid: UUID())
        manager.add(todo)
        XCTAssertNil(manager.todoData.first?.todo)
    }
}

