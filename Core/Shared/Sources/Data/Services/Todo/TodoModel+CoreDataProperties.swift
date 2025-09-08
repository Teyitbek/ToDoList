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

extension TodoModel: TodoRepresentable, @unchecked Sendable { // warning
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64
    @NSManaged public var todo: String?
    @NSManaged public var completed: Bool
}

extension TodoModel: Identifiable {
    func update(model: TodoModel) {
        self.id = model.id
        self.userId = model.userId
        self.todo = model.todo
        self.completed = model.completed
    }
    
    func deleteModel() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
