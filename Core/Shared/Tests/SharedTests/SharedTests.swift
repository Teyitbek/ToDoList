// swiftlint:disable all

import XCTest
@testable import Shared

final class TestCoreDataManager: CoreDataManager {
    override init() {
        super.init()
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
        XCTAssertEqual(manager.model.count, 1)
        XCTAssertEqual(manager.model.first?.todo, "Test note")
        XCTAssertEqual(manager.model.first?.userId, 42)
        XCTAssertFalse(manager.model.first?.completed ?? true)
    }
    
    func testDeleteAllModelsClearsStore() {
        let todo = Todo(todo: "To delete", id: 2, completed: true, userId: 99, uuid: UUID())
        manager.add(todo)

        XCTAssertEqual(manager.model.count, 1)

        manager.deleteAllModels()
        XCTAssertEqual(manager.model.count, 0)
    }

    func testFetchAllModelSortsByCreatedAtDescending() {
        let first = Todo(todo: "First", id: 1, completed: false, userId: 1, uuid: UUID())
        let second = Todo(todo: "Second", id: 2, completed: false, userId: 1, uuid: UUID())

        manager.add(first)
        sleep(1)
        manager.add(second)

        XCTAssertEqual(manager.model.first?.todo, "Second")
    }

    func testAddAssignsUUIDToNewModel() {
        let todo = Todo(todo: "UUID test", id: 3, completed: false, userId: 1, uuid: nil)
        manager.add(todo)

        XCTAssertNotNil(manager.model.first?.uuid)
    }
    
    func testAddTodoWithNilText() {
        let todo = Todo(todo: nil, id: 4, completed: false, userId: 1, uuid: UUID())
        manager.add(todo)
        XCTAssertNil(manager.model.first?.todo)
    }
}

