//
//  CoreDataManager.swift
//  UseCoreData
//
//  Created by Teyit Ajimamatov on 8/9/25.
//

import CoreData
import Domain

public protocol CoreDataManagerProtocol {
}

public class CoreDataManager: CoreDataManagerProtocol {
    public init() {
    }
    
    public var model = [TodoModel]()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoModel")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func fetchAllModel() {
        let request = TodoModel.fetchRequest()
        let sort = NSSortDescriptor(key: "createdAt", ascending: false) 
        request.sortDescriptors = [sort]

        if let model = try? persistentContainer.viewContext.fetch(request) {
            self.model = model
        }
    }
    
    public func add(_ newModel: TodoRepresentable) {
        let model = TodoModel(context: persistentContainer.viewContext)
        model.id = Int64(newModel.id)
        model.userId = Int64(newModel.userId)
        model.completed = newModel.completed
        model.todo = newModel.todo
        model.createdAt = Date()
        model.uuid = UUID()
        saveContext()
        fetchAllModel()
    }
    
    public func deleteAllModels() {
        let request = TodoModel.fetchRequest()
        if let result = try? persistentContainer.viewContext.fetch(request) {
            for object in result {
                persistentContainer.viewContext.delete(object)
            }
            try? persistentContainer.viewContext.save()
            model.removeAll()
        }
    }
}
