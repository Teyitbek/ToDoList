//
//  Model+CoreDataProperties.swift
//  
//
//  Created by Teyit Ajimamatov on 8/9/25.
//
//

import Foundation
import CoreData
import Domain

extension TodoModel: TodoRepresentable, @unchecked Sendable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64
    @NSManaged public var todo: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var uuid: UUID?
    @NSManaged public var completed: Bool
}

extension TodoModel: Identifiable {
    public func update(model: TodoRepresentable) {
        self.id = model.id
        self.userId = model.userId
        self.todo = model.todo
        self.completed = model.completed
        try? managedObjectContext?.save()
    }
    
    public func deleteModel() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
