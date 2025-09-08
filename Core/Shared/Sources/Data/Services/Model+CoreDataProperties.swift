//
//  Model+CoreDataProperties.swift
//  
//
//  Created by Teyit Ajimamatov on 8/9/25.
//
//

import Foundation
import CoreData

extension Model {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Model> {
        return NSFetchRequest<Model>(entityName: "Model")
    }

    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64
    @NSManaged public var todo: String?
    @NSManaged public var completed: Bool
}

extension Model: Identifiable {
    func update(model: Model) {
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
