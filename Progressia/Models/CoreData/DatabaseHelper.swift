//
//  DatabaseHelper.swift
//  Progressia
//
//  Created by William Chrisandy on 23/07/22.
//

import CoreData

class DatabaseHelper: NSObject, ObservableObject
{
    var context = PersistenceController.shared.container.viewContext
    
    override init()
    {
        super.init()
    }
    
    func insert<T: Identifiable>(_ object: T) -> T
    {
        do
        {
            guard let newObject = object as? NSManagedObject else
            {
                print("Object is not a type of NSManagedObject")
                return object
            }
            
            if let objectWithKeyLastId = newObject as? HasKeyLastId
            {
                let keyLastId = type(of: objectWithKeyLastId).keyLastId
                
                guard var objectWithId = objectWithKeyLastId as? HasId else
                {
                    print("Object does not have an id")
                    return object
                }
                
                objectWithId.id = Int64(UserDefaults.standard.integer(forKey: keyLastId) + 1)
                UserDefaults.standard.set(objectWithId.id, forKey: keyLastId)
            }
            context.refreshAllObjects()
            context.insert(newObject)
            try context.save()
        }
        catch
        {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
        }
        
        return object
    }
    
    func delete<T>(_ object: T) -> T
    {
        guard let targetObject = object as? NSManagedObject else
        {
            print("Object is not a type of NSManagedObject")
            return object
        }
        
        context.delete(targetObject)
        saveContext()
        
        return object
    }
    
    func saveContext()
    {
        do
        {
            try context.save()
        }
        catch
        {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
        }
    }
    
    func rollbackContext()
    {
        context.rollback()
    }
}

